<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Admin extends Model
{
    protected $table = 'admins';

    protected $primaryKey = 'id_admin';

    public $timestamps = false;

    protected $fillable = [
        'foto_portada',
        'foto_perfil',
        'nombre',
        'apellido',
        'telefono',
        'descripcion_breve',
        'userLink',
        'parther',
    ];

    protected $casts = [
        'userLink' => 'integer',
        'parther' => 'integer',
    ];
}
