<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreSolicitarInRequest;
use App\Models\SolicitarIn;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Log;
use Throwable;

class SolicitarInController extends Controller
{
    public function store(StoreSolicitarInRequest $request): JsonResponse
    {
        $data = $request->validated();

        try {
            SolicitarIn::query()->create([
                'nombre' => $data['nombre'],
                'telefono' => $data['telefono'],
                'ciudad' => $data['ciudad'],
                'zona' => $data['zona'],
                'tipo_inmueble' => $data['tipo_inmueble'],
                'presupuesto' => $data['presupuesto'],
                'mensaje' => $data['mensaje'],
                'datos_especificos' => $data['datos_especificos'] ?? [],
            ]);

            return response()->json([
                'status' => 'OK',
            ]);
        } catch (Throwable $exception) {
            Log::error('Error en POST /SolicitarIn', [
                'exception' => get_class($exception),
                'message' => $exception->getMessage(),
            ]);

            return response()->json([
                'status' => 'ERROR',
            ], 500);
        }
    }
}
