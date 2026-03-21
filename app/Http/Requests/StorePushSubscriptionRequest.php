<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\Validator;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\Exceptions\HttpResponseException;

class StorePushSubscriptionRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    protected function prepareForValidation(): void
    {
        $deviceId = $this->firstInput(['deviceId', 'device_id', 'DeviceId']);

        $subscription = $this->firstInput(['subscription', 'Subscription']);
        if (is_string($subscription)) {
            $decoded = json_decode($subscription, true);
            if (is_array($decoded)) {
                $subscription = $decoded;
            }
        }

        $endpoint = is_array($subscription)
            ? ($subscription['endpoint'] ?? null)
            : null;

        $p256dh = is_array($subscription) && isset($subscription['keys']) && is_array($subscription['keys'])
            ? ($subscription['keys']['p256dh'] ?? null)
            : null;

        $auth = is_array($subscription) && isset($subscription['keys']) && is_array($subscription['keys'])
            ? ($subscription['keys']['auth'] ?? null)
            : null;

        if ($endpoint === null) {
            $endpoint = $this->firstInput(['endpoint']);
        }
        if ($p256dh === null) {
            $p256dh = $this->firstInput(['p256dh', 'publicKey']);
        }
        if ($auth === null) {
            $auth = $this->firstInput(['auth', 'authToken']);
        }

        $this->merge([
            'deviceId' => $deviceId,
            'subscription' => [
                'endpoint' => $endpoint,
                'keys' => [
                    'p256dh' => $p256dh,
                    'auth' => $auth,
                ],
            ],
        ]);
    }

    public function rules(): array
    {
        return [
            'deviceId' => ['required', 'string', 'max:120'],
            'subscription' => ['required', 'array'],
            'subscription.endpoint' => ['required', 'string', 'url', 'max:700'],
            'subscription.keys' => ['required', 'array'],
            'subscription.keys.p256dh' => ['required', 'string', 'max:4000'],
            'subscription.keys.auth' => ['required', 'string', 'max:500'],
        ];
    }

    protected function failedValidation(Validator $validator): void
    {
        throw new HttpResponseException(
            response()->json(['status' => 'ERROR'], 422)
        );
    }

    private function firstInput(array $keys): mixed
    {
        foreach ($keys as $key) {
            $value = $this->input($key);
            if ($value !== null && $value !== '') {
                return $value;
            }
        }

        return null;
    }
}
