<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreDivisionCierreRequest;
use App\Models\Agente;
use App\Models\Cierre;
use App\Models\DivisionCierre;
use App\Models\User;
use Illuminate\Database\QueryException;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Throwable;

class DivisionCierreController extends Controller
{
    public function store(StoreDivisionCierreRequest $request): JsonResponse
    {
        $authUser = $request->user();
        if (! $authUser) {
            return response()->json([
                'status' => 'ERROR',
            ], 401);
        }

        $data = $request->validated();

        $alreadyExists = DivisionCierre::query()
            ->where('id_cierre', (int) $data['id_cierre'])
            ->where('id_propiedad', (int) $data['id_propiedad'])
            ->exists();

        if ($alreadyExists) {
            return response()->json([
                'status' => 'ERROR',
                'message' => 'Ya existe una division para este cierre y propiedad.',
            ], 409);
        }

        $cierre = Cierre::query()
            ->where('id_cierre', (int) $data['id_cierre'])
            ->first(['id_cierre', 'monto_cerrado']);

        if (! $cierre) {
            return response()->json([
                'status' => 'ERROR',
            ], 404);
        }

        $normalized = $this->normalizeParticipantes((array) $data['participantes']);
        if (! $normalized['ok']) {
            return response()->json([
                'status' => 'ERROR',
                'message' => $normalized['message'],
            ], 422);
        }

        $participantes = $normalized['participantes'];
        $captadores = array_values(array_filter(
            $participantes,
            static fn (array $item): bool => $item['rol'] === 'Captador'
        ));
        $vendedores = array_values(array_filter(
            $participantes,
            static fn (array $item): bool => $item['rol'] === 'Vendedor'
        ));

        if (count($captadores) === 0 || count($vendedores) === 0) {
            return response()->json([
                'status' => 'ERROR',
                'message' => 'Debes enviar al menos un Captador y un Vendedor.',
            ], 422);
        }

        try {
            $montoCerrado = (float) ($cierre->getAttribute('monto_cerrado') ?? 0);
            $comisionTotal = $montoCerrado <= 20000
                ? 1000.0
                : round($montoCerrado * 0.05, 2);

            $comisionInmobiliaria = round($comisionTotal * 0.40, 2);
            $bolsaParticipantes = round($comisionTotal * 0.60, 2);
            $poolCaptadores = round($bolsaParticipantes * 0.50, 2);
            $poolVendedores = round($bolsaParticipantes * 0.50, 2);

            $captadoresMontos = $this->splitAmount($poolCaptadores, count($captadores));
            $vendedoresMontos = $this->splitAmount($poolVendedores, count($vendedores));

            $idxCaptador = 0;
            $idxVendedor = 0;
            $distribucion = [];

            foreach ($participantes as $participante) {
                $monto = 0.0;

                if ($participante['rol'] === 'Captador') {
                    $monto = $captadoresMontos[$idxCaptador] ?? 0.0;
                    $idxCaptador++;
                } else {
                    $monto = $vendedoresMontos[$idxVendedor] ?? 0.0;
                    $idxVendedor++;
                }

                $distribucion[] = [
                    'nombre' => $participante['nombre'],
                    'rol' => $participante['rol'],
                    'monto' => round($monto, 2),
                    'id_agente' => $participante['id_agente'],
                    'id_user' => $participante['id_user'],
                    'email_origen' => $participante['email_origen'],
                ];
            }

            DivisionCierre::query()->create([
                'id_cierre' => (int) $data['id_cierre'],
                'id_propiedad' => (int) $data['id_propiedad'],
                'tipo_afiliacion' => (string) $data['tipo_afiliacion'],
                'monto_cerrado' => round($montoCerrado, 2),
                'comision_total' => round($comisionTotal, 2),
                'comision_inmobiliaria' => round($comisionInmobiliaria, 2),
                'bolsa_participantes' => round($bolsaParticipantes, 2),
                'pool_captadores' => round($poolCaptadores, 2),
                'pool_vendedores' => round($poolVendedores, 2),
                'participantes_json' => $participantes,
                'distribucion_json' => $distribucion,
                'created_by' => (int) $authUser->id,
            ]);

            return response()->json([
                'status' => 'OK',
            ]);
        } catch (QueryException $exception) {
            if (($exception->errorInfo[1] ?? null) === 1062) {
                return response()->json([
                    'status' => 'ERROR',
                    'message' => 'Ya existe una division para este cierre y propiedad.',
                ], 409);
            }

            return response()->json([
                'status' => 'ERROR',
            ], 500);
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
        if ((int) ($authUser->rol ?? 0) !== $ownerRoleId) {
            return response()->json([
                'status' => 'ERROR',
            ], 403);
        }

        $query = DivisionCierre::query();

        $idDivision = $this->queryValue($request, ['id_division']);
        $idCierre = $this->queryValue($request, ['id_cierre']);
        $idPropiedad = $this->queryValue($request, ['id_propiedad']);
        $tipoAfiliacion = $this->queryValue($request, ['tipo_afiliacion']);
        $cantidad = $this->queryValue($request, ['cantidad']);

        if ($idDivision !== null && is_numeric($idDivision)) {
            $query->where('id_division', (int) $idDivision);
        }
        if ($idCierre !== null && is_numeric($idCierre)) {
            $query->where('id_cierre', (int) $idCierre);
        }
        if ($idPropiedad !== null && is_numeric($idPropiedad)) {
            $query->where('id_propiedad', (int) $idPropiedad);
        }
        if ($tipoAfiliacion !== null) {
            $query->where('tipo_afiliacion', mb_strtolower(trim((string) $tipoAfiliacion)));
        }
        if ($cantidad !== null && is_numeric($cantidad) && (int) $cantidad > 0) {
            $query->limit((int) $cantidad);
        }

        $divisiones = $query
            ->orderByDesc('id_division')
            ->get()
            ->map(static function (DivisionCierre $division): array {
                return [
                    'id_division' => $division->getAttribute('id_division'),
                    'id_cierre' => $division->getAttribute('id_cierre'),
                    'id_propiedad' => $division->getAttribute('id_propiedad'),
                    'tipo_afiliacion' => $division->getAttribute('tipo_afiliacion'),
                    'monto_cerrado' => $division->getAttribute('monto_cerrado'),
                    'comision_total' => $division->getAttribute('comision_total'),
                    'comision_inmobiliaria' => $division->getAttribute('comision_inmobiliaria'),
                    'bolsa_participantes' => $division->getAttribute('bolsa_participantes'),
                    'pool_captadores' => $division->getAttribute('pool_captadores'),
                    'pool_vendedores' => $division->getAttribute('pool_vendedores'),
                    'participantes' => $division->getAttribute('participantes_json') ?? [],
                    'distribucion' => $division->getAttribute('distribucion_json') ?? [],
                    'created_by' => $division->getAttribute('created_by'),
                    'created_at' => $division->getAttribute('created_at'),
                    'updated_at' => $division->getAttribute('updated_at'),
                ];
            })
            ->values();

        return response()->json([
            'Divisiones' => $divisiones,
        ]);
    }

    private function normalizeParticipantes(array $rawParticipantes): array
    {
        $normalized = [];

        foreach ($rawParticipantes as $nombreOEmail => $rolRaw) {
            $key = trim((string) $nombreOEmail);
            if ($key === '') {
                return [
                    'ok' => false,
                    'message' => 'Participante invalido.',
                    'participantes' => [],
                ];
            }

            $rol = $this->normalizeRol($rolRaw);
            if ($rol === null) {
                return [
                    'ok' => false,
                    'message' => 'El rol de participante es invalido. Usa Captador o Vendedor.',
                    'participantes' => [],
                ];
            }

            $participant = [
                'nombre' => $key,
                'rol' => $rol,
                'id_agente' => null,
                'id_user' => null,
                'email_origen' => null,
            ];

            if (filter_var($key, FILTER_VALIDATE_EMAIL)) {
                $email = mb_strtolower($key);

                $user = User::query()
                    ->whereRaw('LOWER(email) = ?', [$email])
                    ->first(['id', 'email']);

                if (! $user) {
                    return [
                        'ok' => false,
                        'message' => 'El agente no existe.',
                        'participantes' => [],
                    ];
                }

                $agente = Agente::query()
                    ->where('userLink', (int) $user->getAttribute('id'))
                    ->first(['id_agente', 'nombre', 'apellido', 'userLink']);

                if (! $agente) {
                    return [
                        'ok' => false,
                        'message' => 'El agente no existe.',
                        'participantes' => [],
                    ];
                }

                $nombre = trim((string) $agente->getAttribute('nombre').' '.(string) $agente->getAttribute('apellido'));
                if ($nombre === '') {
                    $nombre = $email;
                }

                $participant['nombre'] = $nombre;
                $participant['id_agente'] = (int) $agente->getAttribute('id_agente');
                $participant['id_user'] = (int) $user->getAttribute('id');
                $participant['email_origen'] = $email;
            }

            $normalized[] = $participant;
        }

        return [
            'ok' => true,
            'message' => null,
            'participantes' => $normalized,
        ];
    }

    private function normalizeRol(mixed $rol): ?string
    {
        if (! is_string($rol)) {
            return null;
        }

        $normalized = mb_strtolower(trim($rol));

        return match ($normalized) {
            'captador' => 'Captador',
            'vendedor' => 'Vendedor',
            default => null,
        };
    }

    private function splitAmount(float $amount, int $parts): array
    {
        if ($parts <= 0) {
            return [];
        }

        $totalCents = (int) round($amount * 100);
        $base = intdiv($totalCents, $parts);
        $remainder = $totalCents % $parts;

        $result = [];
        for ($i = 0; $i < $parts; $i++) {
            $cents = $base + ($i < $remainder ? 1 : 0);
            $result[] = $cents / 100;
        }

        return $result;
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
