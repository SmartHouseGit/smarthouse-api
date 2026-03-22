<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PushConfig extends Model
{
    protected $table = 'push_configs';

    protected $primaryKey = 'id';

    public $timestamps = true;

    protected $fillable = [
        'enabled',
        'paused',
        'pause_until',
        'pre_due_days',
        'pre_due_hour',
        'due_morning_start_hour',
        'due_morning_end_hour',
        'due_afternoon_start_hour',
        'due_afternoon_end_hour',
        'spread_seconds',
        'dispatch_batch_size',
        'retry_delay_minutes',
        'max_attempts',
    ];

    protected $casts = [
        'enabled' => 'boolean',
        'paused' => 'boolean',
        'pause_until' => 'datetime:Y-m-d H:i:s',
        'pre_due_days' => 'array',
        'pre_due_hour' => 'integer',
        'due_morning_start_hour' => 'integer',
        'due_morning_end_hour' => 'integer',
        'due_afternoon_start_hour' => 'integer',
        'due_afternoon_end_hour' => 'integer',
        'spread_seconds' => 'integer',
        'dispatch_batch_size' => 'integer',
        'retry_delay_minutes' => 'integer',
        'max_attempts' => 'integer',
    ];
}
