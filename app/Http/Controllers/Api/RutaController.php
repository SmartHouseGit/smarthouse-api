<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreRutaRequest;
use App\Http\Requests\UpdateRutaRequest;
use App\Models\Agente;
use App\Models\Ruta;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Throwable;

class RutaController extends Controller
{
    public function index(Request $request): JsonResponse
    {
        $authUser = $request->user();
        if (! $authUser) {
            return response()->json([
                'status' => 'ERROR',
            ], 401);
        }

        $ownerRoleId = (int) env('ROLE_OWNER_ID', 1);
        $adminRoleId = (int) env('ROLE_ADMIN_ID', 2);
        $agentRoleId = (int) env('ROLE_AGENT_ID', 3);
        $userRole = (int) ($authUser->rol ?? 0);

        $query = Ruta::query();

        if ($userRole === $adminRoleId) {
            $query->where('ref', (int) $authUser->id);
        } elseif ($userRole === $agentRoleId) {
            $agente = Agente::query()
                ->where('userLink', (int) $authUser->id)
                ->orWhere('id_agente', (int) $authUser->id)
                ->first(['parther']);

            $parther = $agente?->getAttribute('parther');
            if ($parther === null || (int) $parther <= 0) {
                $query->whereRaw('1 = 0');
            } else {
                $query->where('ref', (int) $parther);
            }
        } elseif ($userRole !== $ownerRoleId) {
            return response()->json([
                'status' => 'ERROR',
            ], 403);
        }

        $idRuta = $this->queryValue($request, ['id_ruta']);
        $zona = $this->queryValue($request, ['zona', 'Zona']);
        $ref = $this->queryValue($request, ['ref']);
        $cantidad = $this->queryValue($request, ['cantidad']);

        if ($idRuta !== null && is_numeric($idRuta)) {
            $query->where('id_ruta', (int) $idRuta);
        }
        if ($zona !== null) {
            $query->where('zona', 'like', '%'.$zona.'%');
        }
        if ($ref !== null && is_numeric($ref)) {
            $query->where('ref', (int) $ref);
        }
        if ($cantidad !== null && is_numeric($cantidad) && (int) $cantidad > 0) {
            $query->limit((int) $cantidad);
        }

        $rutas = $query->orderByDesc('id_ruta')->get()->map(static function (Ruta $ruta): array {
            return [
                'id_ruta' => $ruta->getAttribute('id_ruta'),
                'ref' => $ruta->getAttribute('ref'),
                'Zona' => $ruta->getAttribute('zona'),
                'Hora_Inicio' => $ruta->getAttribute('hora_inicio'),
                'Hora_Final' => $ruta->getAttribute('hora_final'),
                'Sectores' => $ruta->getAttribute('sectores') ?? [],
                'Ubicacion_Inicial' => $ruta->getAttribute('ubicacion_inicial') ?? null,
                'Recaudos' => $ruta->getAttribute('recaudos') ?? [],
                'Agentes' => $ruta->getAttribute('agentes'),
                'Resultados' => $ruta->getAttribute('resultados'),
                'Notas' => $ruta->getAttribute('notas'),
            ];
        })->values();

        return response()->json([
            'Rutas' => $rutas,
        ]);
    }

    public function store(StoreRutaRequest $request): JsonResponse
    {
        $authUser = $request->user();
        if (! $authUser) {
            return response()->json([
                'status' => 'ERROR',
            ], 401);
        }

        $adminRoleId = (int) env('ROLE_ADMIN_ID', 2);
        $userRole = (int) ($authUser->rol ?? 0);

        if ($userRole !== $adminRoleId) {
            return response()->json([
                'status' => 'ERROR',
            ], 403);
        }

        $data = $request->validated();

        try {
            Ruta::query()->create([
                'ref' => (int) $authUser->id,
                'zona' => $data['zona'],
                'hora_inicio' => $data['hora_inicio'],
                'hora_final' => $data['hora_final'],
                'sectores' => $data['sectores'],
                'ubicacion_inicial' => $data['ubicacion_inicial'],
                'recaudos' => $data['recaudos'],
                'agentes' => null,
                'resultados' => null,
                'notas' => null,
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

    public function update(UpdateRutaRequest $request): JsonResponse
    {
        $authUser = $request->user();
        if (! $authUser) {
            return response()->json([
                'status' => 'ERROR',
            ], 401);
        }

        $ownerRoleId = (int) env('ROLE_OWNER_ID', 1);
        $adminRoleId = (int) env('ROLE_ADMIN_ID', 2);
        $agentRoleId = (int) env('ROLE_AGENT_ID', 3);
        $userRole = (int) ($authUser->rol ?? 0);

        if (! in_array($userRole, [$ownerRoleId, $adminRoleId, $agentRoleId], true)) {
            return response()->json([
                'status' => 'ERROR',
            ], 403);
        }

        $payload = $request->validated();
        $idRuta = (int) $payload['id_ruta'];
        unset($payload['id_ruta']);

        $query = Ruta::query()->where('id_ruta', $idRuta);

        if ($userRole === $adminRoleId) {
            $query->where('ref', (int) $authUser->id);
        } elseif ($userRole === $agentRoleId) {
            $agente = Agente::query()
                ->where('userLink', (int) $authUser->id)
                ->orWhere('id_agente', (int) $authUser->id)
                ->first(['parther']);

            $parther = $agente?->getAttribute('parther');
            if ($parther === null || (int) $parther <= 0) {
                return response()->json([
                    'status' => 'ERROR',
                ], 404);
            }

            $query->where('ref', (int) $parther);
        }

        $ruta = $query->first();
        if (! $ruta) {
            return response()->json([
                'status' => 'ERROR',
            ], 404);
        }

        $dataToUpdate = [];
        if (array_key_exists('resultados', $payload)) {
            $dataToUpdate['resultados'] = $payload['resultados'];
        }
        if (array_key_exists('nota', $payload)) {
            $dataToUpdate['notas'] = $payload['nota'];
        }

        try {
            $ruta->fill($dataToUpdate);
            $ruta->save();

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
