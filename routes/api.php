<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AgenteController;
use App\Http\Controllers\Api\CiudadController;
use App\Http\Controllers\Api\ClienteController;
use App\Http\Controllers\Api\ContactoController;
use App\Http\Controllers\Api\MediaController;
use App\Http\Controllers\Api\PropiedadController;
use App\Http\Controllers\Api\PublicarInController;
use App\Http\Controllers\Api\SolicitarInController;
use App\Http\Controllers\Api\TestimonioController;

Route::get('/media/{path}', [MediaController::class, 'show'])
    ->where('path', '.*')
    ->middleware('signed')
    ->name('media.private');

Route::get('/testimonios', [TestimonioController::class, 'index']);
Route::post('/contacto', [ContactoController::class, 'store']);
Route::post('/publicarIn', [PublicarInController::class, 'store']);
Route::post('/SolicitarIn', [SolicitarInController::class, 'store']);
Route::get('/ciudades', [CiudadController::class, 'index']);
Route::get('/obtPropiedades', [PropiedadController::class, 'index']);
Route::post('/setPropiedades', [PropiedadController::class, 'store']);
Route::get('/obtAgentes', [AgenteController::class, 'index']);
Route::post('/setAgente', [AgenteController::class, 'store']);
Route::patch('/updAgente/{id_agente}', [AgenteController::class, 'update']);
Route::get('/obtClientes', [ClienteController::class, 'index']);
Route::post('/setCliente', [ClienteController::class, 'store']);
Route::patch('/updCliente/{id_cliente}', [ClienteController::class, 'update']);
