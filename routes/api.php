<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\CiudadController;
use App\Http\Controllers\Api\ContactoController;
use App\Http\Controllers\Api\PublicarInController;
use App\Http\Controllers\Api\SolicitarInController;
use App\Http\Controllers\Api\TestimonioController;

Route::get('/testimonios', [TestimonioController::class, 'index']);
Route::post('/contacto', [ContactoController::class, 'store']);
Route::post('/publicarIn', [PublicarInController::class, 'store']);
Route::post('/SolicitarIn', [SolicitarInController::class, 'store']);
Route::get('/ciudades', [CiudadController::class, 'index']);
