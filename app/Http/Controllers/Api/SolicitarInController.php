<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreSolicitarInRequest;
use App\Models\SolicitarIn;
use Illuminate\Http\JsonResponse;
use Throwable;

class SolicitarInController extends Controller
{
    public function store(StoreSolicitarInRequest $request): JsonResponse
    {
        try {
            SolicitarIn::query()->create($request->validated());

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
