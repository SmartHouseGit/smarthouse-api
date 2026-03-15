<?php

return [
    'paths' => ['*'], // importante por tus rutas sin /api
    'allowed_methods' => ['*'],
    'allowed_origins' => ['https://smarthouse-sve.com', 'https://www.smarthouse-ve.com'],
    'allowed_origins_patterns' => [],
    'allowed_headers' => ['*'],
    'exposed_headers' => [],
    'max_age' => 0,
    'supports_credentials' => false,
];
