<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\StorePropiedadRequest;
use App\Models\Agente;
use App\Models\Propiedad;
use App\Support\CityRegistryService;
use App\Support\PrivateMediaUrl;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\UploadedFile;
use Throwable;

class PropiedadController extends Controller
{
    public function __construct(private readonly CityRegistryService $cityRegistry)
    {
    }

    public function index(Request $request): JsonResponse
    {
        $query = Propiedad::query();

        $idInterno = $this->queryValue($request, ['id_interno', 'ID_interno']);
        $idPublico = $this->queryValue($request, ['id_publico', 'ID_publico']);
        $nombre = $this->queryValue($request, ['nombre', 'Nombre']);
        $tagline = $this->queryValue($request, ['tagline', 'Tagline']);
        $ciudadEstado = $this->queryValue($request, ['ciudad_estado', 'Ciudad_Estado']);
        $zona = $this->queryValue($request, ['zona', 'Zona']);
        $tipoInmueble = $this->queryValue($request, ['tipo_inmueble', 'Tipo_Inmueble']);
        $estadoInterno = $this->queryValue($request, ['estado_interno', 'Estado_Interno']);
        $estadoPublico = $this->queryValue($request, ['estado_publico', 'Estado_Publico']);
        $idAgente = $this->queryValue($request, ['id_agente', 'ID_Agente', 'agente_encargado', 'Agente_Encargado']);
        $propietario = $this->queryValue($request, ['propietario', 'Propietario', 'id_propietario', 'ID_Propietario']);
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
        if ($tagline !== null) {
            $query->where('tagline', 'like', '%'.$tagline.'%');
        }
        if ($ciudadEstado !== null) {
            $query->where('ciudad_estado', 'like', '%'.$ciudadEstado.'%');
        }
        if ($zona !== null) {
            $query->where('zona', 'like', '%'.$zona.'%');
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
        if ($idAgente !== null && is_numeric($idAgente)) {
            $query->where('id_agente', (int) $idAgente);
        }
        if ($propietario !== null && is_numeric($propietario)) {
            $query->where('propietario', (int) $propietario);
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

        $propiedadesResult = $query->get();

        $agentesById = Agente::query()
            ->whereIn('id_agente', $propiedadesResult->pluck('id_agente')->filter()->unique()->values())
            ->get(['id_agente', 'nombre', 'apellido'])
            ->keyBy('id_agente');

        $propiedades = $propiedadesResult->map(function (Propiedad $propiedad) use ($agentesById): array {
            $fotosSecundarias = $propiedad->getAttribute('fotos_secundarias') ?? [];
            if (! is_array($fotosSecundarias)) {
                $fotosSecundarias = [];
            }

            $idAgente = $propiedad->getAttribute('id_agente');
            $agente = $idAgente !== null ? $agentesById->get((int) $idAgente) : null;
            $agenteEncargado = $idAgente;

            if ($agente instanceof Agente) {
                $nombreCompleto = trim(($agente->getAttribute('nombre') ?? '').' '.($agente->getAttribute('apellido') ?? ''));
                if ($nombreCompleto !== '') {
                    $agenteEncargado = $nombreCompleto;
                }
            }

            return [
                'id_interno' => $propiedad->getAttribute('id_interno'),
                'id_publico' => $propiedad->getAttribute('id_publico'),
                'Nombre' => $propiedad->getAttribute('nombre'),
                'Tagline' => $propiedad->getAttribute('tagline'),
                'Ciudad_Estado' => $propiedad->getAttribute('ciudad_estado'),
                'Zona' => $propiedad->getAttribute('zona'),
                'Tipo_Inmueble' => $propiedad->getAttribute('tipo_inmueble'),
                'Precio' => (float) $propiedad->getAttribute('precio'),
                'Estado_Interno' => $propiedad->getAttribute('estado_interno'),
                'Estado_Publico' => $propiedad->getAttribute('estado_publico'),
                'Detalles' => $propiedad->getAttribute('detalles'),
                'Datos_Especificos' => $propiedad->getAttribute('datos_especificos') ?? [],
                'id_agente' => $idAgente,
                'Agente_Encargado' => $agenteEncargado,
                'Propietario' => $propiedad->getAttribute('propietario'),
                'Coordenadas' => [
                    'latitud' => $propiedad->getAttribute('latitud'),
                    'longitud' => $propiedad->getAttribute('longitud'),
                ],
                'Fotos' => [
                    'principal' => PrivateMediaUrl::make($propiedad->getAttribute('foto_principal')),
                    'secundarias' => PrivateMediaUrl::mapMany($fotosSecundarias),
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

        $fotoPrincipal = $request->file('foto_principal')->store('propiedades', 'local');

        $fotosSecundarias = [];
        if ($request->hasFile('fotos_secundarias')) {
            $files = $request->file('fotos_secundarias');
            if (! is_array($files)) {
                $files = [$files];
            }

            foreach ($files as $file) {
                if ($file instanceof UploadedFile) {
                    $fotosSecundarias[] = $file->store('propiedades', 'local');
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
            $this->cityRegistry->ensureExists($this->extractCityName((string) $data['ciudad_estado']));

            Propiedad::query()->create([
                'id_publico' => $data['id_publico'],
                'nombre' => $data['nombre'],
                'tagline' => $data['tagline'],
                'ciudad_estado' => $data['ciudad_estado'],
                'zona' => $data['zona'],
                'tipo_inmueble' => $data['tipo_inmueble'],
                'precio' => $data['precio'],
                'estado_interno' => $data['estado_interno'],
                'estado_publico' => $data['estado_publico'],
                'detalles' => $data['detalles'],
                'datos_especificos' => $data['datos_especificos'],
                'id_agente' => $data['id_agente'],
                'propietario' => $data['propietario'] ?? null,
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

    private function extractCityName(string $ciudadEstado): string
    {
        $ciudadEstado = trim($ciudadEstado);
        if ($ciudadEstado === '') {
            return '';
        }

        $parts = preg_split('/,/', $ciudadEstado, 2);

        return trim((string) ($parts[0] ?? $ciudadEstado));
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
