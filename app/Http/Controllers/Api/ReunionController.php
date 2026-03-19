<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreReunionRequest;
use App\Http\Requests\UpdateReunionRequest;
use App\Models\Agente;
use App\Models\Reunion;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Throwable;

class ReunionController extends Controller
{
    public function index(Request $request): JsonResponse
    {
        $authUser = $request->user();
        if (! $authUser) {
            return response()->json([
                'status' => 'ERROR',
            ], 401);
        }

        $adminRoleId = (int) env('ROLE_ADMIN_ID', 2);
        $agentRoleId = (int) env('ROLE_AGENT_ID', 3);
        $userRole = (int) ($authUser->rol ?? 0);

        $selValue = $this->queryValue($request, ['sel', 'Sel']);
        $sel = filter_var($selValue, FILTER_VALIDATE_BOOL, FILTER_NULL_ON_FAILURE);
        if ($sel === null) {
            $sel = false;
        }

        $query = Reunion::query();

        if ($userRole === $adminRoleId) {
            if ($sel) {
                $agentUserLinks = Agente::query()
                    ->where('parther', (int) $authUser->id)
                    ->pluck('userLink')
                    ->filter(static fn (mixed $id): bool => $id !== null && $id !== '')
                    ->map(static fn (mixed $id): int => (int) $id)
                    ->unique()
                    ->values();

                if ($agentUserLinks->isEmpty()) {
                    $query->whereRaw('1 = 0');
                } else {
                    $query->whereIn('ref', $agentUserLinks->all());
                }
            } else {
                $query->where('ref', (int) $authUser->id);
            }
        } elseif ($userRole === $agentRoleId) {
            $query->where('ref', (int) $authUser->id);
        } else {
            return response()->json([
                'status' => 'ERROR',
            ], 403);
        }

        $reuniones = $query->orderByDesc('id_reunion')->get()->map(static function (Reunion $reunion): array {
            $fechaValue = $reunion->getAttribute('fecha');
            if ($fechaValue instanceof \DateTimeInterface) {
                $fechaValue = $fechaValue->format('Y-m-d');
            }

            return [
                'id_reunion' => $reunion->getAttribute('id_reunion'),
                'Titulo' => $reunion->getAttribute('titulo'),
                'Fecha' => $fechaValue,
                'Hora' => $reunion->getAttribute('hora'),
                'Lugar' => $reunion->getAttribute('lugar'),
                'id_cliente' => $reunion->getAttribute('id_cliente'),
                'Notas' => $reunion->getAttribute('notas'),
                'ref' => $reunion->getAttribute('ref'),
                'mod' => (bool) $reunion->getAttribute('mod'),
                'Estado' => $reunion->getAttribute('estado'),
            ];
        })->values();

        return response()->json([
            'Reuniones' => $reuniones,
        ]);
    }

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

    public function update(UpdateReunionRequest $request): JsonResponse
    {
        $authUser = $request->user();
        if (! $authUser) {
            return response()->json([
                'status' => 'ERROR',
            ], 401);
        }

        $payload = $request->validated();
        $idReunion = (int) $payload['id_reunion'];
        unset($payload['id_reunion']);

        $reunion = Reunion::query()->where('id_reunion', $idReunion)->first();
        if (! $reunion) {
            return response()->json([
                'status' => 'ERROR',
            ], 404);
        }

        try {
            $reunion->fill($payload);
            $reunion->save();

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
