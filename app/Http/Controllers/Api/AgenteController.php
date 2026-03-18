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

        $agentes = $query->get()->map(static function (Agente $agente): array {
            return [
                'id_agente' => $agente->getAttribute('id_agente'),
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
        unset($payload['foto_portada'], $payload['foto_perfil']);

        if ($request->hasFile('foto_portada')) {
            $payload['foto_portada'] = $request->file('foto_portada')->store('agentes', 'local');
        }

        if ($request->hasFile('foto_perfil')) {
            $payload['foto_perfil'] = $request->file('foto_perfil')->store('agentes', 'local');
        }

        try {
            $agente->fill($payload);
            $agente->save();

            return response()->json([
                'status' => 'OK',
            ]);
        } catch (Throwable $exception) {
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
