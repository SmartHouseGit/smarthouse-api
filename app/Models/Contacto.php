<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Contacto extends Model
{
    protected $table = 'contactos';

    public $timestamps = false;

    protected $fillable = [
        'tipo',
        'nombre',
        'email',
        'objetivo',
        'mensaje',
    ];
}
