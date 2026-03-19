<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Cierre extends Model
{
    protected $table = 'cierres';

    protected $primaryKey = 'id_cierre';

    public $timestamps = false;

    protected $fillable = [
        'ref',
        'fecha',
        'tipo_cierre',
        'estado_cierre',
        'codigos_propiedades',
        'titulo',
        'precio_base',
        'monto_cerrado',
        'id_cliente',
        'ciudad',
        'archivos',
        'nota',
    ];

    protected $casts = [
        'ref' => 'integer',
        'fecha' => 'date:Y-m-d',
        'codigos_propiedades' => 'array',
        'precio_base' => 'decimal:2',
        'monto_cerrado' => 'decimal:2',
        'id_cliente' => 'integer',
        'archivos' => 'array',
    ];
}
