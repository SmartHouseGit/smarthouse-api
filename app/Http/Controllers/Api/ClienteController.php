<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreClienteRequest;
use App\Http\Requests\UpdateClienteRequest;
use App\Models\Agente;
use App\Models\Cliente;
use App\Support\CityRegistryService;
use App\Support\PrivateMediaUrl;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Throwable;

class ClienteController extends Controller
{
    public function __construct(private readonly CityRegistryService $cityRegistry)
    {
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

        $query = Cliente::query();

        if ($userRole === $adminRoleId) {
            $subordinateAgents = Agente::query()
                ->where('parther', (int) $authUser->id)
                ->get(['id_agente', 'userLink']);

            $allowedAgentRes = $subordinateAgents
                ->flatMap(static function (Agente $agente): array {
                    $ids = [];

                    $userLink = $agente->getAttribute('userLink');
                    if ($userLink !== null) {
                        $ids[] = (int) $userLink;
                    }

                    $idAgente = $agente->getAttribute('id_agente');
                    if ($idAgente !== null) {
                        $ids[] = (int) $idAgente;
                    }

                    return $ids;
                })
                ->unique()
                ->values();

            if ($allowedAgentRes->isEmpty()) {
                $query->whereRaw('1 = 0');
            } else {
                $query->whereIn('agente_res', $allowedAgentRes->all());
            }
        } elseif ($userRole === $agentRoleId) {
            $query->where('agente_res', (int) $authUser->id);
        } elseif ($userRole !== $ownerRoleId) {
            return response()->json([
                'status' => 'ERROR',
            ], 403);
        }

        $idCliente = $this->queryValue($request, ['id_cliente']);
        $nombre = $this->queryValue($request, ['nombre', 'Nombre']);
        $tipo = $this->queryValue($request, ['tipo', 'Tipo']);
        $estado = $this->queryValue($request, ['estado', 'Estado']);
        $telefono = $this->queryValue($request, ['telefono', 'Telefono']);
        $correo = $this->queryValue($request, ['correo', 'Correo', 'email', 'Email']);
        $ciudad = $this->queryValue($request, ['ciudad', 'Ciudad']);
        $documentoRif = $this->queryValue($request, ['documento_rif', 'Documento_RIF', 'RIF']);
        $agenteRes = $this->queryValue($request, ['agente_res', 'Agente_Res', 'id_agente']);
        $cantidad = $this->queryValue($request, ['cantidad', 'Cantidad']);

        if ($idCliente !== null) {
            $query->where('id_cliente', $idCliente);
        }
        if ($nombre !== null) {
            $query->where('nombre', 'like', '%'.$nombre.'%');
        }
        if ($tipo !== null) {
            $query->where('tipo', 'like', '%'.$tipo.'%');
        }
        if ($estado !== null) {
            $query->where('estado', 'like', '%'.$estado.'%');
        }
        if ($telefono !== null) {
            $query->where('telefono', 'like', '%'.$telefono.'%');
        }
        if ($correo !== null) {
            $query->where('correo', 'like', '%'.$correo.'%');
        }
        if ($ciudad !== null) {
            $query->where('ciudad', 'like', '%'.$ciudad.'%');
        }
        if ($documentoRif !== null) {
            $query->where('documento_rif', 'like', '%'.$documentoRif.'%');
        }
        if ($agenteRes !== null && is_numeric($agenteRes)) {
            $query->where('agente_res', (int) $agenteRes);
        }
        if ($cantidad !== null && is_numeric($cantidad) && (int) $cantidad > 0) {
            $query->limit((int) $cantidad);
        }

        $clientes = $query->get()->map(static function (Cliente $cliente): array {
            return [
                'id_cliente' => $cliente->getAttribute('id_cliente'),
                'Foto' => PrivateMediaUrl::make($cliente->getAttribute('foto')),
                'Portada' => PrivateMediaUrl::make($cliente->getAttribute('portada')),
                'Nombre' => $cliente->getAttribute('nombre'),
                'Perfil' => $cliente->getAttribute('perfil'),
                'Tipo' => $cliente->getAttribute('tipo'),
                'Estado' => $cliente->getAttribute('estado'),
                'Telefono' => $cliente->getAttribute('telefono'),
                'Correo' => $cliente->getAttribute('correo'),
                'Direccion' => $cliente->getAttribute('direccion'),
                'Ciudad' => $cliente->getAttribute('ciudad'),
                'Documento_RIF' => $cliente->getAttribute('documento_rif'),
                'Notas' => $cliente->getAttribute('notas'),
                'agente_res' => $cliente->getAttribute('agente_res'),
            ];
        })->values();

        return response()->json([
            'Clientes' => $clientes,
        ]);
    }

    public function store(StoreClienteRequest $request): JsonResponse
    {
        $creator = $request->user();
        if (! $creator) {
            return response()->json([
                'status' => 'ERROR',
            ], 401);
        }

        $data = $request->validated();

        try {
            $this->cityRegistry->ensureExists((string) $data['ciudad']);

            $foto = $request->file('foto')->store('clientes', 'local');
            $portada = $request->file('portada')->store('clientes', 'local');

            Cliente::query()->create([
                'foto' => $foto,
                'portada' => $portada,
                'nombre' => $data['nombre'],
                'perfil' => $data['perfil'],
                'tipo' => $data['tipo'],
                'estado' => $data['estado'],
                'telefono' => $data['telefono'],
                'correo' => $data['correo'],
                'direccion' => $data['direccion'],
                'ciudad' => $data['ciudad'],
                'documento_rif' => $data['documento_rif'],
                'notas' => $data['notas'] ?? null,
                'agente_res' => (int) $creator->id,
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

    public function update(UpdateClienteRequest $request, int $id_cliente): JsonResponse
    {
        $cliente = Cliente::query()->where('id_cliente', $id_cliente)->first();

        if (! $cliente) {
            return response()->json([
                'status' => 'ERROR',
            ], 404);
        }

        $payload = $request->validated();
        unset($payload['foto'], $payload['portada']);

        if ($request->hasFile('foto')) {
            $payload['foto'] = $request->file('foto')->store('clientes', 'local');
        }

        if ($request->hasFile('portada')) {
            $payload['portada'] = $request->file('portada')->store('clientes', 'local');
        }

        try {
            $cliente->fill($payload);
            $cliente->save();

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
