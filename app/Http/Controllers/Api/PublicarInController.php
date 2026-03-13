<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\StorePublicarInRequest;
use App\Models\PublicarIn;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\UploadedFile;
use Throwable;

class PublicarInController extends Controller
{
    public function store(StorePublicarInRequest $request): JsonResponse
    {
        $data = $request->validated();
        $imagenReferencial = $data['imagen_referencial'];

        if ($imagenReferencial instanceof UploadedFile || $request->hasFile('imagen_referencial')) {
            $imagenReferencial = $request->file('imagen_referencial')->store('publicar-in', 'public');
        }

        try {
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
            return response()->json([
                'status' => 'ERROR',
            ], 500);
        }
    }
}
