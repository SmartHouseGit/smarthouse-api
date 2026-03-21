<?php

return [
    'test_token' => env('PUSH_TEST_TOKEN'),

    'vapid' => [
        'subject' => env('WEB_PUSH_VAPID_SUBJECT'),
        'public_key' => env('WEB_PUSH_VAPID_PUBLIC_KEY'),
        'private_key' => env('WEB_PUSH_VAPID_PRIVATE_KEY'),
    ],
];
