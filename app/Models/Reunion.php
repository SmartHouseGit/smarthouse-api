<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Reunion extends Model
{
    protected $table = 'reuniones';

    protected $primaryKey = 'id_reunion';

    public $timestamps = false;

    protected $fillable = [
        'titulo',
        'fecha',
        'hora',
        'lugar',
        'id_cliente',
        'notas',
        'ref',
        'mod',
        'estado',
    ];

    protected $casts = [
        'fecha' => 'date:Y-m-d',
        'id_cliente' => 'integer',
        'ref' => 'integer',
        'mod' => 'boolean',
    ];
}
