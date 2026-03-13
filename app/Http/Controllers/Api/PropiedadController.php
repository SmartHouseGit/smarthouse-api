<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\StorePropiedadRequest;
use App\Models\Propiedad;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\UploadedFile;
use Throwable;

class PropiedadController extends Controller
{
    public function index(Request $request): JsonResponse
    {
        $query = Propiedad::query();

        $idInterno = $this->queryValue($request, ['id_interno', 'ID_interno']);
        $idPublico = $this->queryValue($request, ['id_publico', 'ID_publico']);
        $nombre = $this->queryValue($request, ['nombre', 'Nombre']);
        $ciudadEstado = $this->queryValue($request, ['ciudad_estado', 'Ciudad_Estado']);
        $tipoInmueble = $this->queryValue($request, ['tipo_inmueble', 'Tipo_Inmueble']);
        $estadoInterno = $this->queryValue($request, ['estado_interno', 'Estado_Interno']);
        $estadoPublico = $this->queryValue($request, ['estado_publico', 'Estado_Publico']);
        $agente = $this->queryValue($request, ['agente_encargado', 'Agente_Encargado']);
        $precioMin = $this->queryValue($request, ['precio_min']);
        $precioMax = $this->queryValue($request, ['precio_max']);
        $cantidad = $this->queryValue($request, ['cantidad', 'Cantidad']);

        if ($idInterno !== null) {
            $query->where('id_interno', $idInterno);
        }
        if ($idPublico !== null) {
            $query->where('id_publico', 'like', '%'.$idPublico.'%');
        }
        if ($nombre !== null) {
            $query->where('nombre', 'like', '%'.$nombre.'%');
        }
        if ($ciudadEstado !== null) {
            $query->where('ciudad_estado', 'like', '%'.$ciudadEstado.'%');
        }
        if ($tipoInmueble !== null) {
            $query->where('tipo_inmueble', 'like', '%'.$tipoInmueble.'%');
        }
        if ($estadoInterno !== null) {
            $query->where('estado_interno', 'like', '%'.$estadoInterno.'%');
        }
        if ($estadoPublico !== null) {
            $query->where('estado_publico', 'like', '%'.$estadoPublico.'%');
        }
        if ($agente !== null) {
            $query->where('agente_encargado', 'like', '%'.$agente.'%');
        }
        if ($precioMin !== null && is_numeric($precioMin)) {
            $query->where('precio', '>=', $precioMin);
        }
        if ($precioMax !== null && is_numeric($precioMax)) {
            $query->where('precio', '<=', $precioMax);
        }

        $this->applyJsonFilter($query, $request, 'dormitorios');
        $this->applyJsonFilter($query, $request, 'banos');
        $this->applyJsonFilter($query, $request, 'area_m2');
        $this->applyJsonFilter($query, $request, 'estacionamientos');
        $this->applyJsonFilter($query, $request, 'ano_construccion');
        $this->applyJsonFilter($query, $request, 'con_piscina', true);
        $this->applyJsonFilter($query, $request, 'pet_friendly', true);
        $this->applyJsonFilter($query, $request, 'amoblada', true);
        $this->applyJsonFilter($query, $request, 'balcon', true);
        $this->applyJsonFilter($query, $request, 'seguridad_privada', true);
        $this->applyJsonFilter($query, $request, 'financiable', true);

        $latitud = $this->queryValue($request, ['latitud']);
        $longitud = $this->queryValue($request, ['longitud']);

        if ($latitud !== null && is_numeric($latitud)) {
            $query->where('latitud', (float) $latitud);
        }
        if ($longitud !== null && is_numeric($longitud)) {
            $query->where('longitud', (float) $longitud);
        }

        if ($cantidad !== null && is_numeric($cantidad) && (int) $cantidad > 0) {
            $query->limit((int) $cantidad);
        }

        $propiedades = $query->get()->map(static function (Propiedad $propiedad): array {
            return [
                'id_interno' => $propiedad->getAttribute('id_interno'),
                'id_publico' => $propiedad->getAttribute('id_publico'),
                'Nombre' => $propiedad->getAttribute('nombre'),
                'Ciudad_Estado' => $propiedad->getAttribute('ciudad_estado'),
                'Tipo_Inmueble' => $propiedad->getAttribute('tipo_inmueble'),
                'Precio' => (float) $propiedad->getAttribute('precio'),
                'Estado_Interno' => $propiedad->getAttribute('estado_interno'),
                'Estado_Publico' => $propiedad->getAttribute('estado_publico'),
                'Detalles' => $propiedad->getAttribute('detalles'),
                'Datos_Especificos' => $propiedad->getAttribute('datos_especificos') ?? [],
                'Agente_Encargado' => $propiedad->getAttribute('agente_encargado'),
                'Coordenadas' => [
                    'latitud' => $propiedad->getAttribute('latitud'),
                    'longitud' => $propiedad->getAttribute('longitud'),
                ],
                'Fotos' => [
                    'principal' => $propiedad->getAttribute('foto_principal'),
                    'secundarias' => $propiedad->getAttribute('fotos_secundarias') ?? [],
                ],
            ];
        })->values();

        return response()->json([
            'Propiedades' => $propiedades,
        ]);
    }

    public function store(StorePropiedadRequest $request): JsonResponse
    {
        $data = $request->validated();

        $fotoPrincipal = $data['foto_principal'];
        if ($fotoPrincipal instanceof UploadedFile || $request->hasFile('foto_principal')) {
            $fotoPrincipal = $request->file('foto_principal')->store('propiedades', 'public');
        }

        $fotosSecundarias = $data['fotos_secundarias'] ?? [];
        if ($request->hasFile('fotos_secundarias')) {
            $fotosSecundarias = [];
            $files = $request->file('fotos_secundarias');
            if (! is_array($files)) {
                $files = [$files];
            }

            foreach ($files as $file) {
                if ($file instanceof UploadedFile) {
                    $fotosSecundarias[] = $file->store('propiedades', 'public');
                }
            }
        }

        if (! is_array($fotosSecundarias)) {
            $fotosSecundarias = [$fotosSecundarias];
        }

        if (count($fotosSecundarias) > 8) {
            return response()->json([
                'status' => 'ERROR',
            ], 422);
        }

        try {
            Propiedad::query()->create([
                'id_publico' => $data['id_publico'],
                'nombre' => $data['nombre'],
                'ciudad_estado' => $data['ciudad_estado'],
                'tipo_inmueble' => $data['tipo_inmueble'],
                'precio' => $data['precio'],
                'estado_interno' => $data['estado_interno'],
                'estado_publico' => $data['estado_publico'],
                'detalles' => $data['detalles'],
                'datos_especificos' => $data['datos_especificos'],
                'agente_encargado' => $data['agente_encargado'],
                'latitud' => $data['coordenadas']['latitud'],
                'longitud' => $data['coordenadas']['longitud'],
                'foto_principal' => $fotoPrincipal,
                'fotos_secundarias' => $fotosSecundarias,
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

    private function applyJsonFilter($query, Request $request, string $field, bool $castBool = false): void
    {
        $value = $this->queryValue($request, [$field]);
        if ($value === null) {
            return;
        }

        if ($castBool) {
            $value = filter_var($value, FILTER_VALIDATE_BOOL, FILTER_NULL_ON_FAILURE);
            if ($value === null) {
                return;
            }
        }

        $query->where("datos_especificos->{$field}", $value);
    }
}
