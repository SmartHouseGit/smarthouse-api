<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreAgenteRequest;
use App\Http\Requests\UpdateAgenteRequest;
use App\Models\Agente;
use App\Models\User;
use App\Support\PrivateMediaUrl;
use Illuminate\Database\QueryException;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use Throwable;

class AgenteController extends Controller
{
    public function index(Request $request): JsonResponse
    {
        $authUser = $request->user();
        if (! $authUser) {
            return response()->json([
                'status' => 'ERROR',
            ], 401);
        }

        $query = Agente::query()->where('parther', (int) $authUser->id);

        $idAgente = $this->queryValue($request, ['id_agente']);
        $nombre = $this->queryValue($request, ['nombre', 'Nombre']);
        $apellido = $this->queryValue($request, ['apellido', 'Apellido']);
        $telefono = $this->queryValue($request, ['telefono', 'Telefono']);
        $cantidad = $this->queryValue($request, ['cantidad', 'Cantidad']);

        if ($idAgente !== null) {
            $query->where('id_agente', $idAgente);
        }
        if ($nombre !== null) {
            $query->where('nombre', 'like', '%'.$nombre.'%');
        }
        if ($apellido !== null) {
            $query->where('apellido', 'like', '%'.$apellido.'%');
        }
        if ($telefono !== null) {
            $query->where('telefono', 'like', '%'.$telefono.'%');
        }
        if ($cantidad !== null && is_numeric($cantidad) && (int) $cantidad > 0) {
            $query->limit((int) $cantidad);
        }

        $agentesCollection = $query->get();

        $userIds = $agentesCollection->pluck('userLink')
            ->filter(static fn (mixed $id): bool => $id !== null && $id !== '')
            ->map(static fn (mixed $id): int => (int) $id)
            ->unique()
            ->values();

        $emailsByUserId = $userIds->isEmpty()
            ? collect()
            : User::query()
                ->whereIn('id', $userIds->all())
                ->pluck('email', 'id');

        $agentes = $agentesCollection->map(static function (Agente $agente) use ($emailsByUserId): array {
            $userLink = (int) $agente->getAttribute('userLink');

            return [
                'id_agente' => $agente->getAttribute('id_agente'),
                'Email' => $emailsByUserId->get($userLink),
                'Foto_Portada' => PrivateMediaUrl::make($agente->getAttribute('foto_portada')),
                'Foto_Perfil' => PrivateMediaUrl::make($agente->getAttribute('foto_perfil')),
                'Nombre' => $agente->getAttribute('nombre'),
                'Apellido' => $agente->getAttribute('apellido'),
                'Telefono' => $agente->getAttribute('telefono'),
                'Descripcion_Breve' => $agente->getAttribute('descripcion_breve'),
            ];
        })->values();

        return response()->json([
            'Agentes' => $agentes,
        ]);
    }

    public function store(StoreAgenteRequest $request): JsonResponse
    {
        $creator = $request->user();
        if (! $creator) {
            return response()->json([
                'status' => 'ERROR',
            ], 401);
        }

        $data = $request->validated();
        $storedFiles = [];

        try {
            DB::beginTransaction();

            $fullName = trim($data['nombre'].' '.$data['apellido']);
            if ($fullName === '') {
                $fullName = $data['usuario'];
            }

            $user = User::query()->create([
                'name' => $fullName,
                'email' => $data['usuario'],
                'password' => $data['password'],
                'rol' => (int) env('ROLE_AGENT_ID', 3),
            ]);

            $fotoPortada = null;
            if ($request->hasFile('foto_portada')) {
                $fotoPortada = $request->file('foto_portada')->store('agentes', 'local');
                $storedFiles[] = $fotoPortada;
            }

            $fotoPerfil = null;
            if ($request->hasFile('foto_perfil')) {
                $fotoPerfil = $request->file('foto_perfil')->store('agentes', 'local');
                $storedFiles[] = $fotoPerfil;
            }

            Agente::query()->create([
                'userLink' => $user->id,
                'parther' => (int) $creator->id,
                'foto_portada' => $fotoPortada,
                'foto_perfil' => $fotoPerfil,
                'nombre' => $data['nombre'],
                'apellido' => $data['apellido'],
                'telefono' => $data['telefono'],
                'descripcion_breve' => $data['descripcion_breve'],
            ]);

            DB::commit();

            return response()->json([
                'status' => 'OK',
            ]);
        } catch (Throwable $exception) {
            DB::rollBack();

            foreach ($storedFiles as $path) {
                if (is_string($path) && $path !== '') {
                    Storage::disk('local')->delete($path);
                }
            }

            if ($exception instanceof QueryException && (string) $exception->getCode() === '23000') {
                return response()->json([
                    'status' => 'ERROR',
                ], 409);
            }

            return response()->json([
                'status' => 'ERROR',
            ], 500);
        }
    }

    public function update(UpdateAgenteRequest $request, int $id_agente): JsonResponse
    {
        $agente = Agente::query()->where('id_agente', $id_agente)->first();

        if (! $agente) {
            return response()->json([
                'status' => 'ERROR',
            ], 404);
        }

        $payload = $request->validated();
        $agentePayload = $payload;
        $userPayload = [];

        $oldFotoPortada = $agente->getAttribute('foto_portada');
        $oldFotoPerfil = $agente->getAttribute('foto_perfil');
        $newFotoPortada = null;
        $newFotoPerfil = null;

        unset($agentePayload['foto_portada'], $agentePayload['foto_perfil']);

        if ($request->hasFile('foto_portada')) {
            $newFotoPortada = $request->file('foto_portada')->store('agentes', 'local');
            $agentePayload['foto_portada'] = $newFotoPortada;
        }

        if ($request->hasFile('foto_perfil')) {
            $newFotoPerfil = $request->file('foto_perfil')->store('agentes', 'local');
            $agentePayload['foto_perfil'] = $newFotoPerfil;
        }

        if (array_key_exists('usuario', $payload)) {
            $userPayload['email'] = $payload['usuario'];
            unset($agentePayload['usuario']);
        }

        if (array_key_exists('password', $payload)) {
            $userPayload['password'] = $payload['password'];
            unset($agentePayload['password']);
        }

        if (array_key_exists('nombre', $payload) || array_key_exists('apellido', $payload)) {
            $nombre = (string) ($agentePayload['nombre'] ?? $agente->getAttribute('nombre') ?? '');
            $apellido = (string) ($agentePayload['apellido'] ?? $agente->getAttribute('apellido') ?? '');
            $fullName = trim($nombre.' '.$apellido);

            if ($fullName !== '') {
                $userPayload['name'] = $fullName;
            }
        }

        try {
            DB::beginTransaction();

            if ($userPayload !== []) {
                $userId = (int) $agente->getAttribute('userLink');
                $user = User::query()->where('id', $userId)->first();

                if (! $user) {
                    DB::rollBack();

                    if (is_string($newFotoPortada) && $newFotoPortada !== '') {
                        Storage::disk('local')->delete($newFotoPortada);
                    }
                    if (is_string($newFotoPerfil) && $newFotoPerfil !== '') {
                        Storage::disk('local')->delete($newFotoPerfil);
                    }

                    return response()->json([
                        'status' => 'ERROR',
                    ], 404);
                }

                $user->fill($userPayload);
                $user->save();
            }

            $agente->fill($agentePayload);
            $agente->save();

            DB::commit();

            if (
                is_string($newFotoPortada) &&
                $newFotoPortada !== '' &&
                is_string($oldFotoPortada) &&
                $oldFotoPortada !== '' &&
                ! preg_match('/^https?:\/\//i', $oldFotoPortada)
            ) {
                Storage::disk('local')->delete($oldFotoPortada);
            }

            if (
                is_string($newFotoPerfil) &&
                $newFotoPerfil !== '' &&
                is_string($oldFotoPerfil) &&
                $oldFotoPerfil !== '' &&
                ! preg_match('/^https?:\/\//i', $oldFotoPerfil)
            ) {
                Storage::disk('local')->delete($oldFotoPerfil);
            }

            return response()->json([
                'status' => 'OK',
            ]);
        } catch (Throwable $exception) {
            DB::rollBack();

            if (is_string($newFotoPortada) && $newFotoPortada !== '') {
                Storage::disk('local')->delete($newFotoPortada);
            }
            if (is_string($newFotoPerfil) && $newFotoPerfil !== '') {
                Storage::disk('local')->delete($newFotoPerfil);
            }

            if ($exception instanceof QueryException && (string) $exception->getCode() === '23000') {
                return response()->json([
                    'status' => 'ERROR',
                ], 409);
            }

            return response()->json([
                'status' => 'ERROR',
            ], 500);
        }
    }

    private function queryValue(Request $request, array $keys): mixed
    {
        foreach ($keys as $key) {
            $value = $request->query($key);
            if ($value !== null && $value !== '') {
                return $value;
            }
        }

        return null;
    }
}
