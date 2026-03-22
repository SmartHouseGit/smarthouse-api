<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PushNotification extends Model
{
    protected $table = 'push_notifications';

    protected $primaryKey = 'id';

    public $timestamps = true;

    protected $fillable = [
        'loan_id',
        'loan_cut_id',
        'event_type',
        'event_date',
        'event_hour',
        'dedupe_key',
        'title',
        'body',
        'url',
        'tag',
        'scheduled_at',
        'status',
        'attempts',
        'recipients',
        'success_count',
        'failed_count',
        'sent_at',
        'last_error',
    ];

    protected $casts = [
        'loan_id' => 'integer',
        'loan_cut_id' => 'integer',
        'event_date' => 'date:Y-m-d',
        'event_hour' => 'integer',
        'scheduled_at' => 'datetime:Y-m-d H:i:s',
        'sent_at' => 'datetime:Y-m-d H:i:s',
        'attempts' => 'integer',
        'recipients' => 'integer',
        'success_count' => 'integer',
        'failed_count' => 'integer',
    ];
}
