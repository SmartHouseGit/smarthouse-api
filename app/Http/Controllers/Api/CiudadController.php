<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Ciudad;
use Illuminate\Http\JsonResponse;

class CiudadController extends Controller
{
    public function index(): JsonResponse
    {
        $ciudades = Ciudad::query()->get()->map(static function (Ciudad $ciudad): array {
            return [
                'id_ciudad' => $ciudad->getAttribute('id_ciudad') ?? $ciudad->getAttribute('id'),
                'Nombre' => $ciudad->getAttribute('nombre') ?? $ciudad->getAttribute('Nombre'),
            ];
        })->values();

        return response()->json([
            'Ciudades' => $ciudades,
            'Testimonios' => $ciudades,
        ]);
    }
}
