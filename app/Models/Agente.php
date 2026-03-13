<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Agente extends Model
{
    protected $table = 'agentes';

    protected $primaryKey = 'id_agente';

    public $timestamps = false;

    protected $fillable = [
        'foto_portada',
        'foto_perfil',
        'nombre',
        'apellido',
        'telefono',
        'descripcion_breve',
    ];
}
