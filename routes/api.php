<?php

use App\Http\Controllers\Api\AdminController;
use App\Http\Controllers\Api\AgenteController;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\CierreController;
use App\Http\Controllers\Api\CiudadController;
use App\Http\Controllers\Api\ClienteController;
use App\Http\Controllers\Api\ConfigController;
use App\Http\Controllers\Api\ContactoController;
use App\Http\Controllers\Api\LoanController;
use App\Http\Controllers\Api\MediaController;
use App\Http\Controllers\Api\MensajeController;
use App\Http\Controllers\Api\PropiedadController;
use App\Http\Controllers\Api\PublicarInController;
use App\Http\Controllers\Api\PushController;
use App\Http\Controllers\Api\ReunionController;
use App\Http\Controllers\Api\RutaController;
use App\Http\Controllers\Api\SolicitarInController;
use App\Http\Controllers\Api\SolicitudesController;
use App\Http\Controllers\Api\TestimonioController;
use Illuminate\Support\Facades\Route;

Route::post('/login', [AuthController::class, 'login']);
Route::patch('/changePassword', [AuthController::class, 'changePassword'])->middleware('auth:sanctum');
Route::post('/push/subscribe', [PushController::class, 'subscribe'])->middleware('auth:sanctum');
Route::post('/push/send-test', [PushController::class, 'sendTest']);
Route::post('/setPushConfig', [PushController::class, 'setConfig']);
Route::get('/obtPushConfig', [PushController::class, 'getConfig']);
Route::get('/obtPushMonitor', [PushController::class, 'monitor']);

Route::post('/loans', [LoanController::class, 'store'])->middleware('auth:sanctum');
Route::get('/loans', [LoanController::class, 'index'])->middleware('auth:sanctum');
Route::patch('/loans/{id}', [LoanController::class, 'update'])->middleware('auth:sanctum');
Route::patch('/loans/{id}/data', [LoanController::class, 'updateData'])->middleware('auth:sanctum');
Route::delete('/loans/{id}', [LoanController::class, 'destroy'])->middleware('auth:sanctum');

Route::get('/media/{path}', [MediaController::class, 'show'])
    ->where('path', '.*')
    ->middleware('signed')
    ->name('media.private');

Route::get('/testimonios', [TestimonioController::class, 'index']);
Route::get('/obtConfig', [ConfigController::class, 'show']);
Route::post('/contacto', [ContactoController::class, 'store']);
Route::post('/publicarIn', [PublicarInController::class, 'store']);
Route::post('/SolicitarIn', [SolicitarInController::class, 'store']);
Route::get('/listSol', [SolicitudesController::class, 'list'])->middleware('auth:sanctum');
Route::post('/delegarCon', [SolicitudesController::class, 'delegar'])->middleware('auth:sanctum');
Route::patch('/updSol', [SolicitudesController::class, 'updateEstado'])->middleware('auth:sanctum');
Route::get('/ciudades', [CiudadController::class, 'index']);
Route::get('/obtPropiedades', [PropiedadController::class, 'index']);
Route::post('/setPropiedades', [PropiedadController::class, 'store']);
Route::get('/obtAdmins', [AdminController::class, 'index']);
Route::post('/setAdmin', [AdminController::class, 'store'])->middleware('auth:sanctum');
Route::patch('/updAdmin/{id_admin}', [AdminController::class, 'update'])->middleware('auth:sanctum');
Route::get('/obtAgentes', [AgenteController::class, 'index'])->middleware('auth:sanctum');
Route::post('/setAgente', [AgenteController::class, 'store'])->middleware('auth:sanctum');
Route::patch('/updAgente/{id_agente}', [AgenteController::class, 'update'])->middleware('auth:sanctum');
Route::get('/obtClientes', [ClienteController::class, 'index'])->middleware('auth:sanctum');
Route::post('/setCliente', [ClienteController::class, 'store'])->middleware('auth:sanctum');
Route::get('/obtCierres', [CierreController::class, 'index'])->middleware('auth:sanctum');
Route::post('/setCierre', [CierreController::class, 'store'])->middleware('auth:sanctum');
Route::patch('/updCierre', [CierreController::class, 'update'])->middleware('auth:sanctum');
Route::get('/obtReuniones', [ReunionController::class, 'index'])->middleware('auth:sanctum');
Route::post('/setReunion', [ReunionController::class, 'store'])->middleware('auth:sanctum');
Route::patch('/updReunion', [ReunionController::class, 'update'])->middleware('auth:sanctum');
Route::post('/setRuta', [RutaController::class, 'store'])->middleware('auth:sanctum');
Route::patch('/updRuta', [RutaController::class, 'update'])->middleware('auth:sanctum');
Route::get('/obtRutas', [RutaController::class, 'index'])->middleware('auth:sanctum');
Route::post('/setConfig', [ConfigController::class, 'set'])->middleware('auth:sanctum');
Route::post('/sendMsm', [MensajeController::class, 'store'])->middleware('auth:sanctum');
Route::get('/obtMsm', [MensajeController::class, 'index'])->middleware('auth:sanctum');
Route::patch('/updCliente/{id_cliente}', [ClienteController::class, 'update']);

// Alias opcional para consumir como /api/loans
Route::post('/api/loans', [LoanController::class, 'store'])->middleware('auth:sanctum');
Route::get('/api/loans', [LoanController::class, 'index'])->middleware('auth:sanctum');
Route::patch('/api/loans/{id}', [LoanController::class, 'update'])->middleware('auth:sanctum');
Route::patch('/api/loans/{id}/data', [LoanController::class, 'updateData'])->middleware('auth:sanctum');
Route::delete('/api/loans/{id}', [LoanController::class, 'destroy'])->middleware('auth:sanctum');
