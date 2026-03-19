<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreCierreRequest;
use App\Models\Agente;
use App\Models\Cierre;
use App\Support\PrivateMediaUrl;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use Throwable;

class CierreController extends Controller
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

        $query = Cierre::query();

        if ($userRole === $adminRoleId) {
            $subordinateAgents = Agente::query()
                ->where('parther', (int) $authUser->id)
                ->get(['id_agente', 'userLink']);

            $allowedRefs = $subordinateAgents
                ->flatMap(static function (Agente $agente): array {
                    $ids = [];

                    $idAgente = $agente->getAttribute('id_agente');
                    if ($idAgente !== null) {
                        $ids[] = (int) $idAgente;
                    }

                    $userLink = $agente->getAttribute('userLink');
                    if ($userLink !== null) {
                        $ids[] = (int) $userLink;
                    }

                    return $ids;
                })
                ->unique()
                ->values();

            if ($allowedRefs->isEmpty()) {
                $query->whereRaw('1 = 0');
            } else {
                $query->whereIn('ref', $allowedRefs->all());
            }
        } elseif ($userRole === $agentRoleId) {
            $agente = Agente::query()
                ->where('userLink', (int) $authUser->id)
                ->orWhere('id_agente', (int) $authUser->id)
                ->first(['id_agente', 'userLink']);

            $allowedRefs = collect([(int) $authUser->id]);
            if ($agente) {
                $idAgente = $agente->getAttribute('id_agente');
                if ($idAgente !== null) {
                    $allowedRefs->push((int) $idAgente);
                }

                $userLink = $agente->getAttribute('userLink');
                if ($userLink !== null) {
                    $allowedRefs->push((int) $userLink);
                }
            }

            $query->whereIn('ref', $allowedRefs->unique()->values()->all());
        } elseif ($userRole !== $ownerRoleId) {
            return response()->json([
                'status' => 'ERROR',
            ], 403);
        }

        $idCierre = $this->queryValue($request, ['id_cierre']);
        $fecha = $this->queryValue($request, ['fecha']);
        $tipo = $this->queryValue($request, ['tipo_cierre', 'tipo']);
        $estado = $this->queryValue($request, ['estado_cierre', 'estado']);
        $idCliente = $this->queryValue($request, ['id_cliente']);
        $ciudad = $this->queryValue($request, ['ciudad']);
        $ref = $this->queryValue($request, ['ref', 'id_agente']);
        $cantidad = $this->queryValue($request, ['cantidad']);

        if ($idCierre !== null) {
            $query->where('id_cierre', $idCierre);
        }
        if ($fecha !== null) {
            $query->whereDate('fecha', $fecha);
        }
        if ($tipo !== null) {
            $query->where('tipo_cierre', 'like', '%'.$tipo.'%');
        }
        if ($estado !== null) {
            $query->where('estado_cierre', 'like', '%'.$estado.'%');
        }
        if ($idCliente !== null && is_numeric($idCliente)) {
            $query->where('id_cliente', (int) $idCliente);
        }
        if ($ciudad !== null) {
            $query->where('ciudad', 'like', '%'.$ciudad.'%');
        }
        if ($ref !== null && is_numeric($ref)) {
            $query->where('ref', (int) $ref);
        }
        if ($cantidad !== null && is_numeric($cantidad) && (int) $cantidad > 0) {
            $query->limit((int) $cantidad);
        }

        $cierres = $query->orderByDesc('id_cierre')->get()->map(static function (Cierre $cierre): array {
            $archivos = $cierre->getAttribute('archivos');
            if (! is_array($archivos)) {
                $archivos = [];
            }

            $fechaValue = $cierre->getAttribute('fecha');
            if ($fechaValue instanceof \DateTimeInterface) {
                $fechaValue = $fechaValue->format('Y-m-d');
            }

            return [
                'id_cierre' => $cierre->getAttribute('id_cierre'),
                'ref' => $cierre->getAttribute('ref'),
                'Fecha' => $fechaValue,
                'Tipo_Cierre' => $cierre->getAttribute('tipo_cierre'),
                'Estado_Cierre' => $cierre->getAttribute('estado_cierre'),
                'Codigos_Propiedades' => $cierre->getAttribute('codigos_propiedades') ?? [],
                'Titulo' => $cierre->getAttribute('titulo'),
                'Precio_Base' => $cierre->getAttribute('precio_base'),
                'Monto_Cerrado' => $cierre->getAttribute('monto_cerrado'),
                'id_cliente' => $cierre->getAttribute('id_cliente'),
                'Ciudad' => $cierre->getAttribute('ciudad'),
                'Archivos' => PrivateMediaUrl::mapMany($archivos),
                'Nota' => $cierre->getAttribute('nota'),
            ];
        })->values();

        return response()->json([
            'Cierres' => $cierres,
        ]);
    }

    public function store(StoreCierreRequest $request): JsonResponse
    {
        $authUser = $request->user();
        if (! $authUser) {
            return response()->json([
                'status' => 'ERROR',
            ], 401);
        }

        $agente = Agente::query()
            ->where('userLink', (int) $authUser->id)
            ->orWhere('id_agente', (int) $authUser->id)
            ->first();

        if (! $agente) {
            return response()->json([
                'status' => 'ERROR',
            ], 403);
        }

        $data = $request->validated();
        $storedFiles = [];

        try {
            DB::beginTransaction();

            if ($request->hasFile('archivos')) {
                $files = $request->file('archivos');
                if (! is_array($files)) {
                    $files = [$files];
                }

                foreach ($files as $file) {
                    if ($file instanceof UploadedFile) {
                        $storedFiles[] = $file->store('cierres', 'local');
                    }
                }
            }

            Cierre::query()->create([
                'ref' => (int) $agente->getAttribute('id_agente'),
                'fecha' => $data['fecha'],
                'tipo_cierre' => $data['tipo_cierre'],
                'estado_cierre' => $data['estado_cierre'],
                'codigos_propiedades' => $data['codigos_propiedades'] ?? null,
                'titulo' => $data['titulo'],
                'precio_base' => $data['precio_base'],
                'monto_cerrado' => $data['monto_cerrado'],
                'id_cliente' => $data['id_cliente'] ?? null,
                'ciudad' => $data['ciudad'],
                'archivos' => count($storedFiles) > 0 ? $storedFiles : null,
                'nota' => $data['nota'] ?? null,
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
