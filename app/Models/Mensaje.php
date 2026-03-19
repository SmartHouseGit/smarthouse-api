<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Mensaje extends Model
{
    protected $table = 'mensajes';

    protected $primaryKey = 'id_msm';

    public $timestamps = false;

    protected $fillable = [
        'sender',
        'full',
        'agentes',
        'prioridad',
        'titulo',
        'mensaje',
        'created_at',
    ];

    protected $casts = [
        'sender' => 'integer',
        'full' => 'boolean',
        'agentes' => 'array',
        'created_at' => 'datetime:Y-m-d H:i:s',
    ];
}
