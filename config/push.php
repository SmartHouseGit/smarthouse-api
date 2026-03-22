<?php

$bool = static function (mixed $value, bool $default): bool {
    if ($value === null) {
        return $default;
    }

    if (is_bool($value)) {
        return $value;
    }

    $parsed = filter_var($value, FILTER_VALIDATE_BOOL, FILTER_NULL_ON_FAILURE);

    return $parsed ?? $default;
};

$csvToIntArray = static function (mixed $value, array $default): array {
    if ($value === null || $value === '') {
        return $default;
    }

    if (is_array($value)) {
        $parts = $value;
    } else {
        $parts = explode(',', (string) $value);
    }

    $items = array_values(array_filter(array_map(
        static fn (mixed $item): int => (int) trim((string) $item),
        $parts
    ), static fn (int $item): bool => $item > 0));

    return $items !== [] ? $items : $default;
};

return [
    'test_token' => env('PUSH_TEST_TOKEN'),

    'vapid' => [
        'subject' => env('WEB_PUSH_VAPID_SUBJECT'),
        'public_key' => env('WEB_PUSH_VAPID_PUBLIC_KEY'),
        'private_key' => env('WEB_PUSH_VAPID_PRIVATE_KEY'),
    ],

    'automation' => [
        'enabled' => $bool(env('PUSH_AUTO_ENABLED', true), true),
        'pre_due_days' => $csvToIntArray(env('PUSH_AUTO_PRE_DUE_DAYS', '3,2,1'), [3, 2, 1]),
        'pre_due_hour' => (int) env('PUSH_AUTO_PRE_DUE_HOUR', 9),
        'due_morning_start_hour' => (int) env('PUSH_AUTO_DUE_MORNING_START', 7),
        'due_morning_end_hour' => (int) env('PUSH_AUTO_DUE_MORNING_END', 11),
        'due_afternoon_start_hour' => (int) env('PUSH_AUTO_DUE_AFTERNOON_START', 14),
        'due_afternoon_end_hour' => (int) env('PUSH_AUTO_DUE_AFTERNOON_END', 18),
        'spread_seconds' => (int) env('PUSH_AUTO_SPREAD_SECONDS', 20),
        'dispatch_batch_size' => (int) env('PUSH_AUTO_DISPATCH_BATCH', 100),
        'retry_delay_minutes' => (int) env('PUSH_AUTO_RETRY_MINUTES', 5),
        'max_attempts' => (int) env('PUSH_AUTO_MAX_ATTEMPTS', 3),
    ],
];
