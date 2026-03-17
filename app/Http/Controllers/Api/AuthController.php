<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\LoginRequest;
use App\Models\User;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\RateLimiter;
use Illuminate\Support\Str;

class AuthController extends Controller
{
    public function login(LoginRequest $request): JsonResponse
    {
        $data = $request->validated();

        $usuario = (string) $data['usuario'];
        $password = (string) $data['password'];
        $rateLimitKey = Str::lower('login|'.$usuario.'|'.$request->ip());

        if (RateLimiter::tooManyAttempts($rateLimitKey, 5)) {
            return response()->json([
                'status' => 'ERROR',
                'retry_in' => RateLimiter::availableIn($rateLimitKey),
            ], 429);
        }

        $user = User::query()
            ->where('email', $usuario)
            ->orWhere('name', $usuario)
            ->first();

        if (! $user || ! Hash::check($password, (string) $user->password)) {
            RateLimiter::hit($rateLimitKey, 60);

            return response()->json([
                'status' => 'ERROR',
            ], 401);
        }

        RateLimiter::clear($rateLimitKey);

        $tokenName = $data['device_name'] ?? 'frontend';
        $token = $user->createToken($tokenName)->plainTextToken;

        return response()->json([
            'status' => 'OK',
            'token' => $token,
            'token_type' => 'Bearer',
            'user' => [
                'id' => $user->id,
                'name' => $user->name,
                'email' => $user->email,
            ],
        ]);
    }
}
