<?php

namespace App\Support;

use App\Models\PushSubscription;
use Illuminate\Support\Collection;
use Minishlink\WebPush\Subscription;
use Minishlink\WebPush\WebPush;
use RuntimeException;
use Throwable;

class PushDeliveryService
{
    public function sendToDeviceId(string $deviceId, array $payload): array
    {
        $subscriptions = PushSubscription::query()
            ->where('device_id', $deviceId)
            ->get(['endpoint', 'p256dh', 'auth']);

        return $this->sendToSubscriptions($subscriptions, $payload);
    }

    public function sendToAll(array $payload): array
    {
        $subscriptions = PushSubscription::query()->get(['endpoint', 'p256dh', 'auth']);

        return $this->sendToSubscriptions($subscriptions, $payload);
    }

    /**
     * @param  Collection<int, PushSubscription>  $subscriptions
     * @return array{sent_to:int,success:int,failed:int}
     */
    private function sendToSubscriptions(Collection $subscriptions, array $payload): array
    {
        if ($subscriptions->isEmpty()) {
            return [
                'sent_to' => 0,
                'success' => 0,
                'failed' => 0,
            ];
        }

        $webPush = $this->buildWebPush();

        $encodedPayload = json_encode($payload, JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE);
        if (! is_string($encodedPayload)) {
            throw new RuntimeException('No se pudo serializar el payload de push.');
        }

        $queueErrors = 0;

        foreach ($subscriptions as $row) {
            try {
                $webPush->queueNotification(
                    Subscription::create([
                        'endpoint' => $row->getAttribute('endpoint'),
                        'publicKey' => $row->getAttribute('p256dh'),
                        'authToken' => $row->getAttribute('auth'),
                        'contentEncoding' => 'aes128gcm',
                    ]),
                    $encodedPayload
                );
            } catch (Throwable) {
                $queueErrors++;
            }
        }

        $success = 0;
        $failed = $queueErrors;

        foreach ($webPush->flush() as $report) {
            if ($report->isSuccess()) {
                $success++;
                continue;
            }

            $failed++;

            if (method_exists($report, 'isSubscriptionExpired') && $report->isSubscriptionExpired()) {
                $endpoint = $report->getRequest()->getUri()->__toString();
                PushSubscription::query()->where('endpoint', $endpoint)->delete();
            }
        }

        return [
            'sent_to' => $subscriptions->count(),
            'success' => $success,
            'failed' => $failed,
        ];
    }

    private function buildWebPush(): WebPush
    {
        $subject = (string) config('push.vapid.subject', '');
        $publicKey = (string) config('push.vapid.public_key', '');
        $privateKey = (string) config('push.vapid.private_key', '');

        if ($subject === '' || $publicKey === '' || $privateKey === '') {
            throw new RuntimeException('Configuracion VAPID incompleta.');
        }

        return new WebPush([
            'VAPID' => [
                'subject' => $subject,
                'publicKey' => $publicKey,
                'privateKey' => $privateKey,
            ],
        ]);
    }
}
