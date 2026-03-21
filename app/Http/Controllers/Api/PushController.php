<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\SendPushTestRequest;
use App\Http\Requests\StorePushSubscriptionRequest;
use App\Models\PushSubscription;
use Illuminate\Http\JsonResponse;
use Minishlink\WebPush\Subscription;
use Minishlink\WebPush\WebPush;
use Throwable;

class PushController extends Controller
{
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
        } catch (Throwable $exception) {
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

        $subscriptions = PushSubscription::query()
            ->where('device_id', $data['deviceId'])
            ->get(['endpoint', 'p256dh', 'auth']);

        if ($subscriptions->isEmpty()) {
            return response()->json([
                'status' => 'OK',
                'sent_to' => 0,
                'success' => 0,
                'failed' => 0,
            ]);
        }

        $payload = json_encode([
            'title' => $data['title'],
            'body' => $data['body'],
            'url' => $data['url'] ?? '/',
            'tag' => 'test-push',
        ], JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE);

        try {
            $webPush = new WebPush([
                'VAPID' => [
                    'subject' => $vapidSubject,
                    'publicKey' => $vapidPublicKey,
                    'privateKey' => $vapidPrivateKey,
                ],
            ]);

            foreach ($subscriptions as $row) {
                $webPush->queueNotification(
                    Subscription::create([
                        'endpoint' => $row->getAttribute('endpoint'),
                        'publicKey' => $row->getAttribute('p256dh'),
                        'authToken' => $row->getAttribute('auth'),
                        'contentEncoding' => 'aes128gcm',
                    ]),
                    $payload
                );
            }

            $success = 0;
            $failed = 0;

            foreach ($webPush->flush() as $report) {
                if ($report->isSuccess()) {
                    $success++;
                } else {
                    $failed++;
                }
            }

            return response()->json([
                'status' => 'OK',
                'sent_to' => $subscriptions->count(),
                'success' => $success,
                'failed' => $failed,
            ]);
        } catch (Throwable $exception) {
            return response()->json([
                'status' => 'ERROR',
            ], 500);
        }
    }
}
