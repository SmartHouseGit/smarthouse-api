<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreReunionRequest;
use App\Models\Reunion;
use Illuminate\Http\JsonResponse;
use Throwable;

class ReunionController extends Controller
{
    public function store(StoreReunionRequest $request): JsonResponse
    {
        $authUser = $request->user();
        if (! $authUser) {
            return response()->json([
                'status' => 'ERROR',
            ], 401);
        }

        $data = $request->validated();
        $mod = (bool) $data['mod'];

        $ref = $data['ref'] ?? null;
        if ($mod) {
            $ref = (int) $authUser->id;
        }

        try {
            Reunion::query()->create([
                'titulo' => $data['titulo'],
                'fecha' => $data['fecha'],
                'hora' => $data['hora'],
                'lugar' => $data['lugar'],
                'id_cliente' => $data['id_cliente'] ?? null,
                'notas' => $data['notas'] ?? null,
                'ref' => $ref !== null ? (int) $ref : null,
                'mod' => $mod,
                'estado' => null,
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
