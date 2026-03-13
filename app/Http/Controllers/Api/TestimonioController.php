<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Testimonio;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class TestimonioController extends Controller
{
    public function index(Request $request): JsonResponse
    {
        $cantidad = $request->query('cantidad', $request->query('Cantidad'));
        $cantidad = is_numeric($cantidad) ? (int) $cantidad : null;

        $query = Testimonio::query();

        if ($cantidad !== null && $cantidad > 0) {
            $query->limit($cantidad);
        }

        $testimonios = $query->get()->map(static function (Testimonio $testimonio): array {
            return [
                'id_testimonio' => $testimonio->getAttribute('id_testimonio') ?? $testimonio->getAttribute('id'),
                'Nombre' => $testimonio->getAttribute('nombre') ?? $testimonio->getAttribute('Nombre'),
                'Localizacion' => $testimonio->getAttribute('localizacion') ?? $testimonio->getAttribute('Localizacion'),
                'Testimonio' => $testimonio->getAttribute('testimonio') ?? $testimonio->getAttribute('Testimonio'),
            ];
        })->values();

        return response()->json([
            'Testimonios' => $testimonios,
        ]);
    }
}
