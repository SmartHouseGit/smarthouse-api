<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\DelegarConRequest;
use App\Http\Requests\ListSolRequest;
use App\Models\Contacto;
use App\Models\PublicarIn;
use App\Models\SolicitarIn;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Collection;
use Throwable;

class SolicitudesController extends Controller
{
    private const TYPE_MAP = [
        'cont' => [
            'model' => Contacto::class,
            'origen' => 'cont',
        ],
        'SolIn' => [
            'model' => SolicitarIn::class,
            'origen' => 'SolIn',
        ],
        'PubIn' => [
            'model' => PublicarIn::class,
            'origen' => 'PubIn',
        ],
    ];

    public function list(ListSolRequest $request): JsonResponse
    {
        $authUser = $request->user();
        if (! $authUser) {
            return response()->json([
                'status' => 'ERROR',
            ], 401);
        }

        $data = $request->validated();
        $tipo = $data['tipo'];
        $filter = (bool) ($data['filter'] ?? false);
        $authUserId = (int) $authUser->id;

        try {
            if ($tipo === 'all') {
                $rows = collect();

                foreach (array_keys(self::TYPE_MAP) as $singleType) {
                    $rows = $rows->concat($this->fetchByType($singleType, $filter, $authUserId));
                }

                return response()->json([
                    'status' => 'OK',
                    'tipo' => $tipo,
                    'Registros' => $rows->values(),
                ]);
            }

            return response()->json([
                'status' => 'OK',
                'tipo' => $tipo,
                'Registros' => $this->fetchByType($tipo, $filter, $authUserId)->values(),
            ]);
        } catch (Throwable $exception) {
            return response()->json([
                'status' => 'ERROR',
            ], 500);
        }
    }

    public function delegar(DelegarConRequest $request): JsonResponse
    {
        $authUser = $request->user();
        if (! $authUser) {
            return response()->json([
                'status' => 'ERROR',
            ], 401);
        }

        $data = $request->validated();
        $tipo = $data['tipo'];
        $idRegistro = (int) $data['id_registro'];
        $idAgente = (int) $data['id_agente'];

        try {
            $query = $this->queryForType($tipo);
            $updated = $query
                ->where('id', $idRegistro)
                ->update(['ref' => $idAgente]);

            if ($updated === 0) {
                return response()->json([
                    'status' => 'ERROR',
                ], 404);
            }

            return response()->json([
                'status' => 'OK',
            ]);
        } catch (Throwable $exception) {
            return response()->json([
                'status' => 'ERROR',
            ], 500);
        }
    }

    private function fetchByType(string $tipo, bool $filter, int $authUserId): Collection
    {
        $origen = self::TYPE_MAP[$tipo]['origen'];
        $query = $this->queryForType($tipo)->orderByDesc('id');

        if ($filter) {
            $query
                ->whereNotNull('ref')
                ->where('ref', '<>', '')
                ->where('ref', $authUserId);
        }

        return $query->get()->map(static function (Model $record) use ($origen): array {
            $row = $record->toArray();
            $row['id'] = (int) $record->getAttribute('id');
            $row['origen'] = $origen;

            return $row;
        })->values();
    }

    private function queryForType(string $tipo): Builder
    {
        $modelClass = self::TYPE_MAP[$tipo]['model'];

        return $modelClass::query();
    }
}
