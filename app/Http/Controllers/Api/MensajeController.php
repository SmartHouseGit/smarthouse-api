<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\SendMsmRequest;
use App\Models\Agente;
use App\Models\Mensaje;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Throwable;

class MensajeController extends Controller
{
    public function store(SendMsmRequest $request): JsonResponse
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
        $sender = (int) $data['sender'];

        if ($sender !== (int) $authUser->id) {
            return response()->json([
                'status' => 'ERROR',
            ], 403);
        }

        $full = (bool) $data['full'];

        if ($full) {
            $targetAgents = Agente::query()
                ->where('parther', $sender)
                ->pluck('id_agente')
                ->filter(static fn (mixed $id): bool => $id !== null && $id !== '')
                ->map(static fn (mixed $id): int => (int) $id)
                ->unique()
                ->values();
        } else {
            $provided = collect($data['agentes'] ?? [])
                ->filter(static fn (mixed $id): bool => $id !== null && $id !== '')
                ->map(static fn (mixed $id): int => (int) $id)
                ->unique()
                ->values();

            $targetAgents = Agente::query()
                ->where('parther', $sender)
                ->whereIn('id_agente', $provided->all())
                ->pluck('id_agente')
                ->map(static fn (mixed $id): int => (int) $id)
                ->unique()
                ->values();

            if ($targetAgents->count() !== $provided->count()) {
                return response()->json([
                    'status' => 'ERROR',
                ], 403);
            }
        }

        if ($targetAgents->isEmpty()) {
            return response()->json([
                'status' => 'ERROR',
            ], 422);
        }

        try {
            Mensaje::query()->create([
                'sender' => $sender,
                'full' => $full,
                'agentes' => $targetAgents->all(),
                'prioridad' => $data['prioridad'],
                'titulo' => $data['titulo'],
                'mensaje' => $data['mensaje'],
                'created_at' => now(),
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

        $query = Mensaje::query();

        if ($userRole === $adminRoleId) {
            $query->where('sender', (int) $authUser->id);
        } elseif ($userRole === $agentRoleId) {
            $agente = Agente::query()
                ->where('userLink', (int) $authUser->id)
                ->orWhere('id_agente', (int) $authUser->id)
                ->first(['id_agente', 'userLink']);

            if (! $agente) {
                $query->whereRaw('1 = 0');
            } else {
                $candidateIds = collect([
                    $agente->getAttribute('id_agente'),
                    $agente->getAttribute('userLink'),
                    (int) $authUser->id,
                ])
                    ->filter(static fn (mixed $id): bool => $id !== null && (int) $id > 0)
                    ->map(static fn (mixed $id): int => (int) $id)
                    ->unique()
                    ->values();

                $query->where(function ($subQuery) use ($candidateIds): void {
                    foreach ($candidateIds as $id) {
                        $subQuery->orWhereRaw('JSON_CONTAINS(agentes, ?)', [json_encode($id)]);
                    }
                });
            }
        } elseif ($userRole !== $ownerRoleId) {
            return response()->json([
                'status' => 'ERROR',
            ], 403);
        }

        $idMsm = $this->queryValue($request, ['id_msm']);
        $sender = $this->queryValue($request, ['sender']);
        $prioridad = $this->queryValue($request, ['prioridad']);
        $cantidad = $this->queryValue($request, ['cantidad']);

        if ($idMsm !== null && is_numeric($idMsm)) {
            $query->where('id_msm', (int) $idMsm);
        }
        if ($sender !== null && is_numeric($sender)) {
            $query->where('sender', (int) $sender);
        }
        if ($prioridad !== null) {
            $query->where('prioridad', 'like', '%'.$prioridad.'%');
        }
        if ($cantidad !== null && is_numeric($cantidad) && (int) $cantidad > 0) {
            $query->limit((int) $cantidad);
        }

        $mensajes = $query->orderByDesc('id_msm')->get()->map(static function (Mensaje $mensaje): array {
            $createdAt = $mensaje->getAttribute('created_at');
            if ($createdAt instanceof \DateTimeInterface) {
                $createdAt = $createdAt->format('Y-m-d H:i:s');
            }

            return [
                'id_msm' => $mensaje->getAttribute('id_msm'),
                'Sender' => $mensaje->getAttribute('sender'),
                'Full' => (bool) $mensaje->getAttribute('full'),
                'Agentes' => $mensaje->getAttribute('agentes') ?? [],
                'Prioridad' => $mensaje->getAttribute('prioridad'),
                'Titulo' => $mensaje->getAttribute('titulo'),
                'Mensaje' => $mensaje->getAttribute('mensaje'),
                'Creado_En' => $createdAt,
            ];
        })->values();

        return response()->json([
            'Mensajes' => $mensajes,
        ]);
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
