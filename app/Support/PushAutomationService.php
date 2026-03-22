<?php

namespace App\Support;

use App\Models\LoanCut;
use App\Models\PushConfig;
use App\Models\PushNotification;
use Carbon\Carbon;
use Throwable;

class PushAutomationService
{
    private const LOAN_NOTIFICATION_URL_BASE = 'https://smarthouse-ve.com/V6dsVt232541';
    public function __construct(private readonly PushDeliveryService $delivery)
    {
    }

    public function plan(?Carbon $now = null): array
    {
        $now = ($now ?? now())->copy();
        $config = $this->getEffectiveConfig();

        if (! $this->isDispatchEnabled($config, $now)) {
            return [
                'planned' => 0,
                'skipped' => 0,
                'reason' => 'paused_or_disabled',
            ];
        }

        $candidates = [];
        $today = $now->toDateString();
        $spreadSeconds = max((int) $config['spread_seconds'], 1);

        $preDueDays = collect($config['pre_due_days'])
            ->map(static fn (mixed $day): int => (int) $day)
            ->filter(static fn (int $day): bool => $day > 0)
            ->unique()
            ->sort()
            ->values()
            ->all();

        if ($preDueDays !== [] && $this->isPreDueHour($config, (int) $now->hour)) {
            $targetDates = collect($preDueDays)
                ->map(fn (int $day): string => $now->copy()->addDays($day)->toDateString())
                ->values()
                ->all();

            $cuts = LoanCut::query()
                ->with(['loan:id,full_name'])
                ->where('status', 'pending')
                ->whereIn('due_date', $targetDates)
                ->get();

            foreach ($cuts as $cut) {
                $dueDate = Carbon::parse($cut->getAttribute('due_date'))->startOfDay();
                $daysLeft = $now->copy()->startOfDay()->diffInDays($dueDate, false);

                if (! in_array($daysLeft, $preDueDays, true)) {
                    continue;
                }

                $fullName = trim((string) optional($cut->loan)->getAttribute('full_name'));
                $amount = number_format((float) $cut->getAttribute('amount'), 2, '.', '');
                $dayText = $daysLeft === 1 ? '1 dia' : $daysLeft.' dias';
                $customer = $fullName !== '' ? $fullName : 'Cliente';

                $candidates[] = [
                    'loan_id' => $cut->getAttribute('loan_id'),
                    'loan_cut_id' => $cut->getAttribute('id'),
                    'event_type' => 'pre_due_'.$daysLeft,
                    'event_date' => $today,
                    'event_hour' => null,
                    'dedupe_key' => sprintf('cut:%d:pre_due:%d:%s', (int) $cut->getAttribute('id'), $daysLeft, $today),
                    'title' => 'Recordatorio de corte',
                    'body' => $customer.': tu corte de '.$amount.' vence en '.$dayText.'.',
                    'url' => $this->buildLoanUrl((int) $cut->getAttribute('loan_id'), (int) $cut->getAttribute('id')),
                    'tag' => sprintf(
                        'loan-pre-due-cut-%d-d%d',
                        (int) $cut->getAttribute('id'),
                        $daysLeft
                    ),
                    'status' => 'pending',
                    'attempts' => 0,
                    'recipients' => 0,
                    'success_count' => 0,
                    'failed_count' => 0,
                    'sent_at' => null,
                    'last_error' => null,
                ];
            }
        }

        if ($this->isDueHour($config, (int) $now->hour)) {
            $cutsDueToday = LoanCut::query()
                ->with(['loan:id,full_name'])
                ->where('status', 'pending')
                ->whereDate('due_date', $today)
                ->get();

            foreach ($cutsDueToday as $cut) {
                $fullName = trim((string) optional($cut->loan)->getAttribute('full_name'));
                $amount = number_format((float) $cut->getAttribute('amount'), 2, '.', '');
                $customer = $fullName !== '' ? $fullName : 'Cliente';

                $candidates[] = [
                    'loan_id' => $cut->getAttribute('loan_id'),
                    'loan_cut_id' => $cut->getAttribute('id'),
                    'event_type' => 'due_hourly',
                    'event_date' => $today,
                    'event_hour' => (int) $now->hour,
                    'dedupe_key' => sprintf('cut:%d:due_hourly:%s:%02d', (int) $cut->getAttribute('id'), $today, (int) $now->hour),
                    'title' => 'Corte con vencimiento hoy',
                    'body' => $customer.': hoy vence tu corte de '.$amount.'.',
                    'url' => $this->buildLoanUrl((int) $cut->getAttribute('loan_id'), (int) $cut->getAttribute('id')),
                    'tag' => sprintf(
                        'loan-due-today-cut-%d-h%02d',
                        (int) $cut->getAttribute('id'),
                        (int) $now->hour
                    ),
                    'status' => 'pending',
                    'attempts' => 0,
                    'recipients' => 0,
                    'success_count' => 0,
                    'failed_count' => 0,
                    'sent_at' => null,
                    'last_error' => null,
                ];
            }
        }

        usort($candidates, static function (array $a, array $b): int {
            $priority = static fn (string $event): int => match (true) {
                $event === 'due_hourly' => 1,
                str_starts_with($event, 'pre_due_1') => 2,
                str_starts_with($event, 'pre_due_2') => 3,
                str_starts_with($event, 'pre_due_3') => 4,
                default => 9,
            };

            return $priority((string) $a['event_type']) <=> $priority((string) $b['event_type']);
        });

        $created = 0;
        $skipped = 0;
        $scheduleBase = $now->copy()->startOfMinute();

        foreach ($candidates as $index => $candidate) {
            $candidate['scheduled_at'] = $scheduleBase->copy()->addSeconds($index * $spreadSeconds)->toDateTimeString();

            $record = PushNotification::query()->firstOrCreate(
                ['dedupe_key' => $candidate['dedupe_key']],
                $candidate
            );

            if ($record->wasRecentlyCreated) {
                $created++;
            } else {
                $skipped++;
            }
        }

        return [
            'planned' => $created,
            'skipped' => $skipped,
            'reason' => 'ok',
        ];
    }

    public function dispatch(?Carbon $now = null): array
    {
        $now = ($now ?? now())->copy();
        $config = $this->getEffectiveConfig();

        if (! $this->isDispatchEnabled($config, $now)) {
            return [
                'processed' => 0,
                'sent' => 0,
                'failed' => 0,
                'reason' => 'paused_or_disabled',
            ];
        }

        $batchSize = max((int) $config['dispatch_batch_size'], 1);
        $retryDelay = max((int) $config['retry_delay_minutes'], 1);
        $maxAttempts = max((int) $config['max_attempts'], 1);
        $interMessageDelaySeconds = 15;

        $queue = PushNotification::query()
            ->where('status', 'pending')
            ->where('scheduled_at', '<=', $now->toDateTimeString())
            ->orderBy('scheduled_at')
            ->limit($batchSize)
            ->get();

        $processed = 0;
        $sent = 0;
        $failed = 0;
        $totalRows = $queue->count();

        foreach ($queue->values() as $index => $row) {
            $processed++;

            try {
                $result = $this->delivery->sendToAll([
                    'title' => $row->getAttribute('title'),
                    'body' => $row->getAttribute('body'),
                    'url' => $row->getAttribute('url') ?? '/',
                    'tag' => $row->getAttribute('tag') ?? 'loan-notification',
                    'meta' => [
                        'loanId' => $row->getAttribute('loan_id'),
                        'cutId' => $row->getAttribute('loan_cut_id'),
                        'eventType' => $row->getAttribute('event_type'),
                    ],
                ]);

                $row->setAttribute('attempts', ((int) $row->getAttribute('attempts')) + 1);
                $row->setAttribute('recipients', (int) $result['sent_to']);
                $row->setAttribute('success_count', (int) $result['success']);
                $row->setAttribute('failed_count', (int) $result['failed']);
                $row->setAttribute('status', 'sent');
                $row->setAttribute('sent_at', $now->toDateTimeString());
                $row->setAttribute('last_error', null);
                $row->save();

                $sent++;
            } catch (Throwable $exception) {
                $attempts = ((int) $row->getAttribute('attempts')) + 1;

                $row->setAttribute('attempts', $attempts);
                $row->setAttribute('last_error', mb_substr($exception->getMessage(), 0, 5000));

                if ($attempts >= $maxAttempts) {
                    $row->setAttribute('status', 'failed');
                    $failed++;
                } else {
                    $row->setAttribute('status', 'pending');
                    $row->setAttribute('scheduled_at', $now->copy()->addMinutes($retryDelay)->toDateTimeString());
                }

                $row->save();
            }

            if ($index < ($totalRows - 1)) {
                sleep($interMessageDelaySeconds);
            }
        }

        return [
            'processed' => $processed,
            'sent' => $sent,
            'failed' => $failed,
            'reason' => 'ok',
        ];
    }

    public function getEffectiveConfig(): array
    {
        $defaults = [
            'enabled' => (bool) config('push.automation.enabled', true),
            'paused' => false,
            'pause_until' => null,
            'pre_due_days' => config('push.automation.pre_due_days', [3, 2, 1]),
            'pre_due_hour' => (int) config('push.automation.pre_due_hour', 9),
            'due_morning_start_hour' => (int) config('push.automation.due_morning_start_hour', 7),
            'due_morning_end_hour' => (int) config('push.automation.due_morning_end_hour', 11),
            'due_afternoon_start_hour' => (int) config('push.automation.due_afternoon_start_hour', 14),
            'due_afternoon_end_hour' => (int) config('push.automation.due_afternoon_end_hour', 18),
            'spread_seconds' => (int) config('push.automation.spread_seconds', 20),
            'dispatch_batch_size' => (int) config('push.automation.dispatch_batch_size', 100),
            'retry_delay_minutes' => (int) config('push.automation.retry_delay_minutes', 5),
            'max_attempts' => (int) config('push.automation.max_attempts', 3),
        ];

        $dbConfig = PushConfig::query()->first();

        if (! $dbConfig) {
            return $defaults;
        }

        $preDueDays = $dbConfig->getAttribute('pre_due_days');
        if (! is_array($preDueDays) || $preDueDays === []) {
            $preDueDays = $defaults['pre_due_days'];
        }

        return [
            'enabled' => (bool) $dbConfig->getAttribute('enabled'),
            'paused' => (bool) $dbConfig->getAttribute('paused'),
            'pause_until' => $dbConfig->getAttribute('pause_until'),
            'pre_due_days' => $preDueDays,
            'pre_due_hour' => (int) $dbConfig->getAttribute('pre_due_hour'),
            'due_morning_start_hour' => (int) $dbConfig->getAttribute('due_morning_start_hour'),
            'due_morning_end_hour' => (int) $dbConfig->getAttribute('due_morning_end_hour'),
            'due_afternoon_start_hour' => (int) $dbConfig->getAttribute('due_afternoon_start_hour'),
            'due_afternoon_end_hour' => (int) $dbConfig->getAttribute('due_afternoon_end_hour'),
            'spread_seconds' => max((int) $dbConfig->getAttribute('spread_seconds'), 1),
            'dispatch_batch_size' => max((int) $dbConfig->getAttribute('dispatch_batch_size'), 1),
            'retry_delay_minutes' => max((int) $dbConfig->getAttribute('retry_delay_minutes'), 1),
            'max_attempts' => max((int) $dbConfig->getAttribute('max_attempts'), 1),
        ];
    }

    private function buildLoanUrl(int $loanId, ?int $cutId = null): string
    {
        $base = rtrim(self::LOAN_NOTIFICATION_URL_BASE, '/').'/';

        $params = [
            'view' => 'history',
        ];

        if ($loanId > 0) {
            $params['loanId'] = $loanId;
        }

        if ($cutId !== null && $cutId > 0) {
            $params['cutId'] = $cutId;
        }

        return $base.'?' . http_build_query($params);
    }

    private function isDispatchEnabled(array $config, Carbon $now): bool
    {
        if (! $config['enabled']) {
            return false;
        }

        if (! $config['paused']) {
            return true;
        }

        $pauseUntil = $config['pause_until'];

        if ($pauseUntil === null) {
            return false;
        }

        try {
            return $now->greaterThanOrEqualTo(Carbon::parse($pauseUntil));
        } catch (Throwable) {
            return false;
        }
    }

    private function isPreDueHour(array $config, int $hour): bool
    {
        return $hour === (int) $config['pre_due_hour'];
    }

    private function isDueHour(array $config, int $hour): bool
    {
        $inMorning = $hour >= (int) $config['due_morning_start_hour'] && $hour <= (int) $config['due_morning_end_hour'];
        $inAfternoon = $hour >= (int) $config['due_afternoon_start_hour'] && $hour <= (int) $config['due_afternoon_end_hour'];

        return $inMorning || $inAfternoon;
    }
}
