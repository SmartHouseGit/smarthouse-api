<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AppConfig extends Model
{
    protected $table = 'configs';

    protected $primaryKey = 'id_config';

    public $timestamps = false;

    protected $fillable = [
        'hero_frase',
        'hero_imagen',
        'micelines',
        'destacados',
        'banner',
        'comentarios',
    ];

    protected $casts = [
        'micelines' => 'array',
        'destacados' => 'array',
        'banner' => 'array',
        'comentarios' => 'array',
    ];
}
