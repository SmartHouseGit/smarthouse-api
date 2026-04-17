<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class DivisionCierre extends Model
{
    protected $table = 'division_cierres';

    protected $primaryKey = 'id_division';

    protected $fillable = [
        'id_cierre',
        'id_propiedad',
        'tipo_afiliacion',
        'monto_cerrado',
        'comision_total',
        'comision_inmobiliaria',
        'bolsa_participantes',
        'pool_captadores',
        'pool_vendedores',
        'participantes_json',
        'distribucion_json',
        'created_by',
    ];

    protected $casts = [
        'id_cierre' => 'integer',
        'id_propiedad' => 'integer',
        'monto_cerrado' => 'float',
        'comision_total' => 'float',
        'comision_inmobiliaria' => 'float',
        'bolsa_participantes' => 'float',
        'pool_captadores' => 'float',
        'pool_vendedores' => 'float',
        'participantes_json' => 'array',
        'distribucion_json' => 'array',
        'created_by' => 'integer',
    ];
}
