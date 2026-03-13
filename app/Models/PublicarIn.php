<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PublicarIn extends Model
{
    protected $table = 'publicar_ins';

    public $timestamps = false;

    protected $fillable = [
        'nombre',
        'telefono',
        'ciudad',
        'zona',
        'tipo_inmueble',
        'imagen_referencial',
        'mensaje',
    ];
}
