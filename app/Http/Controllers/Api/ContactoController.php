<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreContactoRequest;
use App\Models\Contacto;
use Illuminate\Http\JsonResponse;
use Throwable;

class ContactoController extends Controller
{
    public function store(StoreContactoRequest $request): JsonResponse
    {
        try {
            Contacto::query()->create($request->validated());

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
