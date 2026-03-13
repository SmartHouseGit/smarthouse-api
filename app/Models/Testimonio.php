<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Testimonio extends Model
{
    protected $table = 'testimonios';

    protected $primaryKey = 'id_testimonio';

    public $timestamps = false;

    protected $fillable = [
        'nombre',
        'localizacion',
        'testimonio',
    ];
}
