<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class SolicitarIn extends Model
{
    protected $table = 'solicitar_ins';

    public $timestamps = false;

    protected $fillable = [
        'nombre',
        'telefono',
        'ciudad',
        'zona',
        'tipo_inmueble',
        'presupuesto',
        'mensaje',
        'datos_especificos',
    ];

    protected $casts = [
        'datos_especificos' => 'array',
    ];
}
