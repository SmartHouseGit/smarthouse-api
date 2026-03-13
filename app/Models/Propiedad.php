<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Propiedad extends Model
{
    protected $table = 'propiedades';

    protected $primaryKey = 'id_interno';

    public $timestamps = false;

    protected $fillable = [
        'id_publico',
        'nombre',
        'ciudad_estado',
        'tipo_inmueble',
        'precio',
        'estado_interno',
        'estado_publico',
        'detalles',
        'datos_especificos',
        'agente_encargado',
        'latitud',
        'longitud',
        'foto_principal',
        'fotos_secundarias',
    ];

    protected $casts = [
        'precio' => 'decimal:2',
        'datos_especificos' => 'array',
        'fotos_secundarias' => 'array',
        'latitud' => 'float',
        'longitud' => 'float',
    ];
}
