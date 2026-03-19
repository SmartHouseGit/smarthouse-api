<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Ruta extends Model
{
    protected $table = 'rutas';

    protected $primaryKey = 'id_ruta';

    public $timestamps = false;

    protected $fillable = [
        'ref',
        'zona',
        'hora_inicio',
        'hora_final',
        'sectores',
        'ubicacion_inicial',
        'recaudos',
        'agentes',
        'resultados',
        'notas',
    ];

    protected $casts = [
        'ref' => 'integer',
        'sectores' => 'array',
        'ubicacion_inicial' => 'array',
        'recaudos' => 'array',
        'agentes' => 'array',
        'resultados' => 'array',
    ];
}
