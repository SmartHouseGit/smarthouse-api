<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\SendPushTestRequest;
use App\Http\Requests\SetPushConfigRequest;
use App\Http\Requests\StorePushSubscriptionRequest;
use App\Models\PushConfig;
use App\Models\PushNotification;
use App\Models\PushSubscription;
use App\Support\PushAutomationService;
use App\Support\PushDeliveryService;
use Carbon\Carbon;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Throwable;

class PushController extends Controller
{
    public function __construct(
        private readonly PushDeliveryService $delivery,
        private readonly PushAutomationService $automation
    ) {
    }

    public function subscribe(StorePushSubscriptionRequest $request): JsonResponse
    {
        $data = $request->validated();
        $subscription = $data['subscription'];

        try {
            PushSubscription::query()->updateOrCreate(
                ['endpoint' => $subscription['endpoint']],
                [
                    'device_id' => $data['deviceId'],
                    'p256dh' => $subscription['keys']['p256dh'],
                    'auth' => $subscription['keys']['auth'],
                ]
            );

            return response()->json([
                'status' => 'OK',
            ]);
        } catch (Throwable) {
            return response()->json([
                'status' => 'ERROR',
            ], 500);
        }
    }

    public function sendTest(SendPushTestRequest $request): JsonResponse
    {
        $expectedToken = (string) config('push.test_token', '');
        $providedToken = (string) $request->header('X-Push-Token', '');

        if ($expectedToken === '' || $providedToken === '' || ! hash_equals($expectedToken, $providedToken)) {
            return response()->json([
                'status' => 'ERROR',
            ], 401);
        }

        $vapidSubject = (string) config('push.vapid.subject', '');
        $vapidPublicKey = (string) config('push.vapid.public_key', '');
        $vapidPrivateKey = (string) config('push.vapid.private_key', '');

        if ($vapidSubject === '' || $vapidPublicKey === '' || $vapidPrivateKey === '') {
            return response()->json([
                'status' => 'ERROR',
            ], 500);
        }

        $data = $request->validated();

        try {
            $result = $this->delivery->sendToDeviceId($data['deviceId'], [
                'title' => $data['title'],
                'body' => $data['body'],
                'url' => $data['url'] ?? '/',
                'tag' => 'test-push',
            ]);

            return response()->json([
                'status' => 'OK',
                'sent_to' => (int) $result['sent_to'],
                'success' => (int) $result['success'],
                'failed' => (int) $result['failed'],
            ]);
        } catch (Throwable) {
            return response()->json([
                'status' => 'ERROR',
            ], 500);
        }
    }

    public function setConfig(SetPushConfigRequest $request): JsonResponse
    {

        $data = $request->validated();

        try {
            $config = PushConfig::query()->first();
            if (! $config) {
                $defaults = $this->automation->getEffectiveConfig();

                $config = PushConfig::query()->create([
                    'enabled' => (bool) ($defaults['enabled'] ?? true),
                    'paused' => (bool) ($defaults['paused'] ?? false),
                    'pause_until' => $this->toDateTimeOrNull($defaults['pause_until'] ?? null),
                    'pre_due_days' => $defaults['pre_due_days'] ?? [3, 2, 1],
                    'pre_due_hour' => (int) ($defaults['pre_due_hour'] ?? 9),
                    'due_morning_start_hour' => (int) ($defaults['due_morning_start_hour'] ?? 7),
                    'due_morning_end_hour' => (int) ($defaults['due_morning_end_hour'] ?? 11),
                    'due_afternoon_start_hour' => (int) ($defaults['due_afternoon_start_hour'] ?? 14),
                    'due_afternoon_end_hour' => (int) ($defaults['due_afternoon_end_hour'] ?? 18),
                    'spread_seconds' => max((int) ($defaults['spread_seconds'] ?? 20), 1),
                    'dispatch_batch_size' => max((int) ($defaults['dispatch_batch_size'] ?? 100), 1),
                    'retry_delay_minutes' => max((int) ($defaults['retry_delay_minutes'] ?? 5), 1),
                    'max_attempts' => max((int) ($defaults['max_attempts'] ?? 3), 1),
                ]);
            }

            $updates = [];

            if (array_key_exists('enabled', $data)) {
                $updates['enabled'] = (bool) $data['enabled'];
            }

            if (array_key_exists('preDueDays', $data)) {
                $days = collect($data['preDueDays'])
                    ->map(static fn (mixed $day): int => (int) $day)
                    ->filter(static fn (int $day): bool => $day > 0)
                    ->unique()
                    ->sort()
                    ->values()
                    ->all();

                if ($days !== []) {
                    $updates['pre_due_days'] = $days;
                }
            }

            if (array_key_exists('preDueHour', $data)) {
                $updates['pre_due_hour'] = (int) $data['preDueHour'];
            }
            if (array_key_exists('dueMorningStartHour', $data)) {
                $updates['due_morning_start_hour'] = (int) $data['dueMorningStartHour'];
            }
            if (array_key_exists('dueMorningEndHour', $data)) {
                $updates['due_morning_end_hour'] = (int) $data['dueMorningEndHour'];
            }
            if (array_key_exists('dueAfternoonStartHour', $data)) {
                $updates['due_afternoon_start_hour'] = (int) $data['dueAfternoonStartHour'];
            }
            if (array_key_exists('dueAfternoonEndHour', $data)) {
                $updates['due_afternoon_end_hour'] = (int) $data['dueAfternoonEndHour'];
            }
            if (array_key_exists('spreadSeconds', $data)) {
                $updates['spread_seconds'] = max((int) $data['spreadSeconds'], 1);
            }
            if (array_key_exists('dispatchBatchSize', $data)) {
                $updates['dispatch_batch_size'] = max((int) $data['dispatchBatchSize'], 1);
            }
            if (array_key_exists('retryDelayMinutes', $data)) {
                $updates['retry_delay_minutes'] = max((int) $data['retryDelayMinutes'], 1);
            }
            if (array_key_exists('maxAttempts', $data)) {
                $updates['max_attempts'] = max((int) $data['maxAttempts'], 1);
            }

            $hasPauseUntil = array_key_exists('pauseUntil', $data);
            $hasPauseMinutes = array_key_exists('pauseMinutes', $data);

            if ($hasPauseMinutes) {
                $updates['paused'] = true;
                $updates['pause_until'] = now()->copy()->addMinutes((int) $data['pauseMinutes'])->toDateTimeString();
            }

            if ($hasPauseUntil) {
                $updates['paused'] = true;
                $updates['pause_until'] = $this->toDateTimeOrNull($data['pauseUntil']);
            }

            if (array_key_exists('paused', $data)) {
                $updates['paused'] = (bool) $data['paused'];

                if ($updates['paused'] === false) {
                    $updates['pause_until'] = null;
                } elseif (! $hasPauseUntil && ! $hasPauseMinutes) {
                    $updates['pause_until'] = null;
                }
            }

            $config->fill($updates);
            $config->save();

            return response()->json([
                'status' => 'OK',
                'Config' => $this->formatConfig($this->automation->getEffectiveConfig()),
            ]);
        } catch (Throwable) {
            return response()->json([
                'status' => 'ERROR',
            ], 500);
        }
    }

    public function getConfig(Request $request): JsonResponse
    {

        return response()->json([
            'status' => 'OK',
            'Config' => $this->formatConfig($this->automation->getEffectiveConfig()),
        ]);
    }

    public function monitor(Request $request): Response
    {

        $now = now();
        $limit = max(min((int) $request->query('limit', 30), 200), 1);
        $config = $this->automation->getEffectiveConfig();

        $pendingCount = PushNotification::query()->where('status', 'pending')->count();
        $sentCount = PushNotification::query()->where('status', 'sent')->count();
        $failedCount = PushNotification::query()->where('status', 'failed')->count();
        $dueNowCount = PushNotification::query()
            ->where('status', 'pending')
            ->where('scheduled_at', '<=', $now->toDateTimeString())
            ->count();

        $nextPending = PushNotification::query()
            ->where('status', 'pending')
            ->orderBy('scheduled_at')
            ->limit($limit)
            ->get([
                'id',
                'event_type',
                'loan_id',
                'loan_cut_id',
                'scheduled_at',
                'attempts',
                'title',
            ]);

        $recent = PushNotification::query()
            ->orderByDesc('id')
            ->limit($limit)
            ->get([
                'id',
                'status',
                'event_type',
                'loan_id',
                'loan_cut_id',
                'scheduled_at',
                'sent_at',
                'recipients',
                'success_count',
                'failed_count',
                'attempts',
                'last_error',
            ]);

        $lines = [];
        $lines[] = 'PUSH MONITOR';
        $lines[] = 'generated_at: '.$now->toDateTimeString();
        $lines[] = 'enabled: '.($config['enabled'] ? 'true' : 'false');
        $lines[] = 'paused: '.($config['paused'] ? 'true' : 'false');
        $lines[] = 'pause_until: '.($this->toDateTimeOrNull($config['pause_until']) ?? 'null');
        $lines[] = 'pre_due_days: '.implode(',', (array) ($config['pre_due_days'] ?? []));
        $lines[] = 'pre_due_hour: '.(int) ($config['pre_due_hour'] ?? 9);
        $lines[] = 'due_window_morning: '.(int) ($config['due_morning_start_hour'] ?? 7).'-'.(int) ($config['due_morning_end_hour'] ?? 11);
        $lines[] = 'due_window_afternoon: '.(int) ($config['due_afternoon_start_hour'] ?? 14).'-'.(int) ($config['due_afternoon_end_hour'] ?? 18);
        $lines[] = 'spread_seconds: '.(int) ($config['spread_seconds'] ?? 20);
        $lines[] = 'dispatch_batch_size: '.(int) ($config['dispatch_batch_size'] ?? 100);
        $lines[] = 'retry_delay_minutes: '.(int) ($config['retry_delay_minutes'] ?? 5);
        $lines[] = 'max_attempts: '.(int) ($config['max_attempts'] ?? 3);
        $lines[] = 'queue.pending: '.$pendingCount;
        $lines[] = 'queue.pending_due_now: '.$dueNowCount;
        $lines[] = 'queue.sent_total: '.$sentCount;
        $lines[] = 'queue.failed_total: '.$failedCount;
        $lines[] = '';
        $lines[] = 'NEXT PENDING (max '.$limit.')';

        foreach ($nextPending as $row) {
            $lines[] = sprintf(
                '#%d | %s | loan:%s cut:%s | at:%s | attempts:%d | %s',
                (int) $row->getAttribute('id'),
                (string) $row->getAttribute('event_type'),
                (string) ($row->getAttribute('loan_id') ?? '-'),
                (string) ($row->getAttribute('loan_cut_id') ?? '-'),
                (string) $row->getAttribute('scheduled_at'),
                (int) $row->getAttribute('attempts'),
                $this->oneLine((string) ($row->getAttribute('title') ?? ''))
            );
        }

        $lines[] = '';
        $lines[] = 'RECENT ACTIVITY (max '.$limit.')';

        foreach ($recent as $row) {
            $lastError = $row->getAttribute('last_error');
            $errorText = $lastError ? ' error: '.$this->oneLine((string) $lastError) : '';

            $lines[] = sprintf(
                '#%d | %s | %s | loan:%s cut:%s | sched:%s | sent:%s | rec:%d ok:%d fail:%d attempts:%d%s',
                (int) $row->getAttribute('id'),
                (string) $row->getAttribute('status'),
                (string) $row->getAttribute('event_type'),
                (string) ($row->getAttribute('loan_id') ?? '-'),
                (string) ($row->getAttribute('loan_cut_id') ?? '-'),
                (string) $row->getAttribute('scheduled_at'),
                (string) ($row->getAttribute('sent_at') ?? '-'),
                (int) $row->getAttribute('recipients'),
                (int) $row->getAttribute('success_count'),
                (int) $row->getAttribute('failed_count'),
                (int) $row->getAttribute('attempts'),
                $errorText
            );
        }

        return response(implode("\n", $lines)."\n", 200, [
            'Content-Type' => 'text/plain; charset=UTF-8',
        ]);
    }


    private function formatConfig(array $config): array
    {
        $pauseUntil = $this->toDateTimeOrNull($config['pause_until'] ?? null);

        $dispatchEnabled = (bool) ($config['enabled'] ?? false);
        if ((bool) ($config['paused'] ?? false)) {
            if ($pauseUntil === null) {
                $dispatchEnabled = false;
            } else {
                $dispatchEnabled = now()->greaterThanOrEqualTo(Carbon::parse($pauseUntil));
            }
        }

        return [
            'enabled' => (bool) ($config['enabled'] ?? true),
            'paused' => (bool) ($config['paused'] ?? false),
            'pauseUntil' => $pauseUntil,
            'preDueDays' => array_values((array) ($config['pre_due_days'] ?? [3, 2, 1])),
            'preDueHour' => (int) ($config['pre_due_hour'] ?? 9),
            'dueMorningStartHour' => (int) ($config['due_morning_start_hour'] ?? 7),
            'dueMorningEndHour' => (int) ($config['due_morning_end_hour'] ?? 11),
            'dueAfternoonStartHour' => (int) ($config['due_afternoon_start_hour'] ?? 14),
            'dueAfternoonEndHour' => (int) ($config['due_afternoon_end_hour'] ?? 18),
            'spreadSeconds' => (int) ($config['spread_seconds'] ?? 20),
            'dispatchBatchSize' => (int) ($config['dispatch_batch_size'] ?? 100),
            'retryDelayMinutes' => (int) ($config['retry_delay_minutes'] ?? 5),
            'maxAttempts' => (int) ($config['max_attempts'] ?? 3),
            'dispatchEnabledNow' => $dispatchEnabled,
        ];
    }

    private function toDateTimeOrNull(mixed $value): ?string
    {
        if ($value === null || $value === '') {
            return null;
        }

        if ($value instanceof \DateTimeInterface) {
            return $value->format('Y-m-d H:i:s');
        }

        try {
            return Carbon::parse((string) $value)->toDateTimeString();
        } catch (Throwable) {
            return null;
        }
    }

    private function oneLine(string $value): string
    {
        return trim((string) preg_replace('/\s+/', ' ', $value));
    }
}
