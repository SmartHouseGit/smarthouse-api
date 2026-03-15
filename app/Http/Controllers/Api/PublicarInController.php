<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\StorePublicarInRequest;
use App\Models\PublicarIn;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Log;
use Throwable;

class PublicarInController extends Controller
{
    public function store(StorePublicarInRequest $request): JsonResponse
    {
        $data = $request->validated();

        try {
            $imagenReferencial = $request->file('imagen_referencial')->store('publicar-in', 'local');

            PublicarIn::query()->create([
                'nombre' => $data['nombre'],
                'telefono' => $data['telefono'],
                'ciudad' => $data['ciudad'],
                'zona' => $data['zona'],
                'tipo_inmueble' => $data['tipo_inmueble'],
                'imagen_referencial' => $imagenReferencial,
                'mensaje' => $data['mensaje'],
            ]);

            return response()->json([
                'status' => 'OK',
            ]);
        } catch (Throwable $exception) {
            Log::error('Error en POST /publicarIn', [
                'exception' => get_class($exception),
                'message' => $exception->getMessage(),
                'file' => $exception->getFile(),
                'line' => $exception->getLine(),
            ]);

            return response()->json([
                'status' => 'ERROR',
                'message' => $exception->getMessage(),
                'exception' => get_class($exception),
                'file' => $exception->getFile(),
                'line' => $exception->getLine(),
            ], 500);
        }
    }
}
