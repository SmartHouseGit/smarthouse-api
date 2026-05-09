<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\Validator;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\Exceptions\HttpResponseException;
use Illuminate\Validation\Rule;

class UpdatePropiedadRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    protected function prepareForValidation(): void
    {
        if (! $this->hasFile('foto_principal') && $this->hasFile('Foto_Principal')) {
            $this->files->set('foto_principal', $this->file('Foto_Principal'));
        }

        if (! $this->hasFile('fotos_secundarias') && $this->hasFile('Fotos_Secundarias')) {
            $this->files->set('fotos_secundarias', $this->file('Fotos_Secundarias'));
        }

        $datosEspecificos = $this->firstInput([
            'datos_especificos',
            'Datos_Especificos',
            'Datos Especificos',
            'datosEspecificos',
        ]);
        $coordenadas = $this->firstInput(['coordenadas', 'Coordenadas']);

        if (is_string($datosEspecificos)) {
            $decoded = json_decode($datosEspecificos, true);
            if (is_array($decoded)) {
                $datosEspecificos = $decoded;
            }
        }

        if (is_string($coordenadas)) {
            $decoded = json_decode($coordenadas, true);
            if (is_array($decoded)) {
                $coordenadas = $decoded;
            }
        }

        $latitud = $this->firstInput(['latitud', 'Latitud']);
        $longitud = $this->firstInput(['longitud', 'Longitud', 'lng', 'Lng']);
        if (is_array($coordenadas)) {
            $latitud = $coordenadas['latitud']
                ?? $coordenadas['Latitud']
                ?? $coordenadas['latitude']
                ?? $coordenadas['lat']
                ?? $latitud;
            $longitud = $coordenadas['longitud']
                ?? $coordenadas['Longitud']
                ?? $coordenadas['longitude']
                ?? $coordenadas['lng']
                ?? $longitud;
        }

        $data = [];

        $idPublico = $this->firstInput(['id_publico', 'ID publico', 'ID_publico', 'idPublico']);
        $nombre = $this->firstInput(['nombre', 'Nombre']);
        $etiqueta = $this->firstInput(['etiqueta', 'Etiqueta']);
        $ciudadEstado = $this->firstInput(['ciudad_estado', 'Ciudad, Estado', 'ciudad, estado', 'Ciudad Estado']);
        $zona = $this->firstInput(['zona', 'Zona']);
        $tipoInmueble = $this->firstInput(['tipo_inmueble', 'Tipo de inmueble', 'tipo de inmueble']);
        $precio = $this->firstInput(['precio', 'Precio']);
        $estadoInterno = $this->firstInput(['estado_interno', 'Estado Interno']);
        $estadoPublico = $this->firstInput(['estado_publico', 'Estado Publico']);
        $detalles = $this->firstInput(['detalles', 'Detalles', 'Detalles en texto']);
        $idAgente = $this->firstInput([
            'id_agente',
            'ID Agente',
            'agente_id',
            'agente_encargado',
            'agente',
            'encargado',
            'Agente',
            'Encargado',
        ]);
        $propietario = $this->firstInput(['propietario', 'Propietario', 'id_propietario', 'ID Propietario']);
        $tipoAf = $this->firstInput(['tipo_af', 'Tipo_AF', 'tipoAF', 'tipo af']);
        $afContent = $this->firstInput(['af_content', 'AF_Content', 'afContent', 'af content']);

        if (is_string($tipoAf)) {
            $tipoAfLower = mb_strtolower(trim($tipoAf));
            if ($tipoAfLower === 'interna') {
                $tipoAf = 'Interna';
            } elseif ($tipoAfLower === 'externa') {
                $tipoAf = 'Externa';
            } elseif ($tipoAfLower === 'ninguna' || $tipoAfLower === 'none') {
                $tipoAf = null;
            }
        }

        if ($idPublico !== null) {
            $data['id_publico'] = $idPublico;
        }
        if ($nombre !== null) {
            $data['nombre'] = $nombre;
        }
        if ($etiqueta !== null) {
            $data['etiqueta'] = $etiqueta;
        }
        if ($ciudadEstado !== null) {
            $data['ciudad_estado'] = $ciudadEstado;
        }
        if ($zona !== null) {
            $data['zona'] = $zona;
        }
        if ($tipoInmueble !== null) {
            $data['tipo_inmueble'] = $tipoInmueble;
        }
        if ($precio !== null) {
            $data['precio'] = $precio;
        }
        if ($estadoInterno !== null) {
            $data['estado_interno'] = $estadoInterno;
        }
        if ($estadoPublico !== null) {
            $data['estado_publico'] = $estadoPublico;
        }
        if ($detalles !== null) {
            $data['detalles'] = $detalles;
        }
        if ($idAgente !== null) {
            $data['id_agente'] = $idAgente;
        }
        if ($propietario !== null) {
            $data['propietario'] = $propietario;
        }
        if ($afContent !== null) {
            $data['af_content'] = $afContent;
        }
        if (is_array($datosEspecificos)) {
            $data['datos_especificos'] = $datosEspecificos;
        }
        if ($latitud !== null || $longitud !== null || is_array($coordenadas)) {
            $data['coordenadas'] = [
                'latitud' => $latitud,
                'longitud' => $longitud,
            ];
        }
        if ($this->hasAny(['tipo_af', 'Tipo_AF', 'tipoAF', 'tipo af'])) {
            $data['tipo_af'] = $tipoAf;
        }

        if ($data !== []) {
            $this->merge($data);
        }
    }

    public function rules(): array
    {
        return [
            'id_publico' => [
                'sometimes',
                'string',
                'max:100',
                Rule::unique('propiedades', 'id_publico')->ignore((int) $this->route('id_interno'), 'id_interno'),
            ],
            'nombre' => ['sometimes', 'string', 'max:180'],
            'etiqueta' => ['sometimes', 'string', 'max:255'],
            'ciudad_estado' => ['sometimes', 'string', 'max:180'],
            'zona' => ['sometimes', 'string', 'max:180'],
            'tipo_inmueble' => ['sometimes', 'string', 'max:120'],
            'precio' => ['sometimes', 'numeric', 'min:0'],
            'estado_interno' => ['sometimes', 'string', 'max:120'],
            'estado_publico' => ['sometimes', 'string', 'max:120'],
            'detalles' => ['sometimes', 'string', 'max:10000'],
            'id_agente' => ['sometimes', 'integer', 'min:1', 'exists:agentes,id_agente'],
            'propietario' => ['sometimes', 'nullable', 'integer', 'min:1'],
            'coordenadas' => ['sometimes', 'array'],
            'coordenadas.latitud' => ['required_with:coordenadas', 'numeric', 'between:-90,90'],
            'coordenadas.longitud' => ['required_with:coordenadas', 'numeric', 'between:-180,180'],
            'datos_especificos' => ['sometimes', 'array'],
            'foto_principal' => ['sometimes', 'file', 'image', 'mimes:jpg,jpeg,png,webp', 'max:8192'],
            'fotos_secundarias' => ['sometimes', 'array', 'max:12'],
            'fotos_secundarias.*' => ['nullable', 'file', 'image', 'mimes:jpg,jpeg,png,webp', 'max:8192'],
            'tipo_af' => ['sometimes', 'nullable', 'string', 'in:Interna,Externa'],
            'af_content' => ['sometimes', 'nullable', 'string', 'max:65535'],
        ];
    }

    public function withValidator($validator): void
    {
        $validator->after(function ($validator): void {
            $hasFields = $this->hasAny([
                'id_publico',
                'nombre',
                'etiqueta',
                'ciudad_estado',
                'zona',
                'tipo_inmueble',
                'precio',
                'estado_interno',
                'estado_publico',
                'detalles',
                'id_agente',
                'propietario',
                'coordenadas',
                'datos_especificos',
                'tipo_af',
                'af_content',
            ]) || $this->hasFile('foto_principal') || $this->hasFile('fotos_secundarias');

            if (! $hasFields) {
                $validator->errors()->add('payload', 'Debe enviar al menos un campo para actualizar.');
            }

            $tipoAfPresent = $this->has('tipo_af');
            $tipoAf = $this->input('tipo_af');
            if ($tipoAfPresent && is_string($tipoAf) && in_array($tipoAf, ['Interna', 'Externa'], true) && ! $this->has('af_content')) {
                $validator->errors()->add('af_content', 'Debe enviar af_content cuando tipo_af sea Interna o Externa.');
            }
        });
    }

    protected function failedValidation(Validator $validator): void
    {
        throw new HttpResponseException(
            response()->json(['status' => 'ERROR'], 422)
        );
    }

    private function firstInput(array $keys): mixed
    {
        foreach ($keys as $key) {
            $value = $this->input($key);
            if ($value !== null && $value !== '') {
                return $value;
            }
        }

        return null;
    }
}
