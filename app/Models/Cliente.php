<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Cliente extends Model
{
    protected $table = 'clientes';

    protected $primaryKey = 'id_cliente';

    public $timestamps = false;

    protected $fillable = [
        'foto',
        'portada',
        'nombre',
        'perfil',
        'tipo',
        'estado',
        'telefono',
        'correo',
        'direccion',
        'ciudad',
        'documento_rif',
        'notas',
        'agente_res',
    ];

    protected $casts = [
        'agente_res' => 'integer',
    ];
}
