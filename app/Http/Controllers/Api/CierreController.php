<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreCierreRequest;
use App\Models\Agente;
use App\Models\Cierre;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use Throwable;

class CierreController extends Controller
{
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
}
