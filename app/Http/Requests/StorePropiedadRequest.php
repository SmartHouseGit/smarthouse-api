<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\Validator;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\Exceptions\HttpResponseException;

class StorePropiedadRequest extends FormRequest
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
        $fotosSecundarias = $this->firstInput([
            'fotos_secundarias',
            'Fotos_Secundarias',
            'Fotos Secundarias',
        ]);

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

        if (is_string($fotosSecundarias)) {
            $decoded = json_decode($fotosSecundarias, true);
            if (is_array($decoded)) {
                $fotosSecundarias = $decoded;
            } elseif ($fotosSecundarias !== '') {
                $fotosSecundarias = [$fotosSecundarias];
            }
        }

        $latitud = $this->firstInput(['latitud', 'Latitud']);
        $longitud = $this->firstInput(['longitud', 'Longitud', 'lng', 'Lng']);
        $tipoAf = $this->firstInput(['tipo_af', 'Tipo_AF', 'tipoAF', 'tipo af']);

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

        if (is_array($datosEspecificos)) {
            $datosEspecificos = array_filter([
                'dormitorios' => $datosEspecificos['dormitorios'] ?? $datosEspecificos['Dormitorios'] ?? null,
                'banos' => $datosEspecificos['banos']
                    ?? $datosEspecificos['baños']
                    ?? $datosEspecificos['Banos']
                    ?? $datosEspecificos['Baños']
                    ?? null,
                'area_m2' => $datosEspecificos['area_m2']
                    ?? $datosEspecificos['area en m2']
                    ?? $datosEspecificos['Area en m2']
                    ?? null,
                'estacionamientos' => $datosEspecificos['estacionamientos']
                    ?? $datosEspecificos['Estacionamientos']
                    ?? null,
                'con_piscina' => $datosEspecificos['con_piscina']
                    ?? $datosEspecificos['piscina']
                    ?? null,
                'pet_friendly' => $datosEspecificos['pet_friendly']
                    ?? $datosEspecificos['pet friendly']
                    ?? null,
                'ano_construccion' => $datosEspecificos['ano_construccion']
                    ?? $datosEspecificos['año de construccion']
                    ?? $datosEspecificos['ano de construccion']
                    ?? null,
                'amoblada' => $datosEspecificos['amoblada'] ?? null,
                'balcon' => $datosEspecificos['balcon'] ?? null,
                'seguridad_privada' => $datosEspecificos['seguridad_privada']
                    ?? $datosEspecificos['seguridad privada']
                    ?? null,
                'financiable' => $datosEspecificos['financiable'] ?? null,
            ], static fn ($value) => $value !== null);
        }

        if (is_string($tipoAf)) {
            $tipoAfLower = mb_strtolower(trim($tipoAf));
            if ($tipoAfLower === 'interna') {
                $tipoAf = 'Interna';
            } elseif ($tipoAfLower === 'externa') {
                $tipoAf = 'Externa';
            }
        }

        $this->merge([
            'id_publico' => $this->firstInput(['id_publico', 'ID publico', 'ID_publico', 'idPublico']),
            'nombre' => $this->firstInput(['nombre', 'Nombre']),
            'tagline' => $this->firstInput(['tagline', 'Tagline']),
            'ciudad_estado' => $this->firstInput([
                'ciudad_estado',
                'Ciudad, Estado',
                'ciudad, estado',
                'Ciudad Estado',
            ]),
            'zona' => $this->firstInput(['zona', 'Zona']),
            'tipo_inmueble' => $this->firstInput([
                'tipo_inmueble',
                'Tipo de inmueble',
                'tipo de inmueble',
            ]),
            'precio' => $this->firstInput(['precio', 'Precio']),
            'estado_interno' => $this->firstInput([
                'estado_interno',
                'Estado Interno',
            ]),
            'estado_publico' => $this->firstInput([
                'estado_publico',
                'Estado Publico',
            ]),
            'detalles' => $this->firstInput(['detalles', 'Detalles', 'Detalles en texto']),
            'id_agente' => $this->firstInput([
                'id_agente',
                'ID Agente',
                'agente_id',
                'agente_encargado',
                'agente',
                'encargado',
                'Agente',
                'Encargado',
            ]),
            'propietario' => $this->firstInput([
                'propietario',
                'Propietario',
                'id_propietario',
                'ID Propietario',
            ]),
            'foto_principal' => $this->firstInput([
                'foto_principal',
                'Foto_Principal',
                'Foto Principal',
            ]),
            'fotos_secundarias' => $fotosSecundarias,
            'coordenadas' => [
                'latitud' => $latitud,
                'longitud' => $longitud,
            ],
            'datos_especificos' => $datosEspecificos,
            'tipo_af' => $tipoAf,
            'af_content' => $this->firstInput(['af_content', 'AF_Content', 'afContent', 'af content']),
        ]);
    }

    public function rules(): array
    {
        return [
            'id_publico' => ['required', 'string', 'max:100'],
            'nombre' => ['required', 'string', 'max:180'],
            'tagline' => ['required', 'string', 'max:255'],
            'ciudad_estado' => ['required', 'string', 'max:180'],
            'zona' => ['required', 'string', 'max:180'],
            'tipo_inmueble' => ['required', 'string', 'max:120'],
            'precio' => ['required', 'numeric', 'min:0'],
            'estado_interno' => ['required', 'string', 'max:120'],
            'estado_publico' => ['required', 'string', 'max:120'],
            'detalles' => ['required', 'string', 'max:10000'],
            'id_agente' => ['required', 'integer', 'min:1', 'exists:agentes,id_agente'],
            'propietario' => ['nullable', 'integer', 'min:1'],
            'coordenadas' => ['required', 'array'],
            'coordenadas.latitud' => ['required', 'numeric', 'between:-90,90'],
            'coordenadas.longitud' => ['required', 'numeric', 'between:-180,180'],
            'datos_especificos' => ['required', 'array'],
            'datos_especificos.dormitorios' => ['nullable', 'integer', 'min:0'],
            'datos_especificos.banos' => ['nullable', 'integer', 'min:0'],
            'datos_especificos.area_m2' => ['nullable', 'numeric', 'min:0'],
            'datos_especificos.estacionamientos' => ['nullable', 'integer', 'min:0'],
            'datos_especificos.con_piscina' => ['nullable', 'boolean'],
            'datos_especificos.pet_friendly' => ['nullable', 'boolean'],
            'datos_especificos.ano_construccion' => ['nullable', 'integer', 'min:1800', 'max:2100'],
            'datos_especificos.amoblada' => ['nullable', 'boolean'],
            'datos_especificos.balcon' => ['nullable', 'boolean'],
            'datos_especificos.seguridad_privada' => ['nullable', 'boolean'],
            'datos_especificos.financiable' => ['nullable', 'boolean'],
            'foto_principal' => ['required', 'file', 'image', 'mimes:jpg,jpeg,png,webp', 'max:8192'],
            'fotos_secundarias' => ['nullable', 'array', 'max:8'],
            'fotos_secundarias.*' => ['nullable', 'file', 'image', 'mimes:jpg,jpeg,png,webp', 'max:8192'],
            'tipo_af' => ['nullable', 'string', 'in:Interna,Externa'],
            'af_content' => ['nullable', 'string', 'max:65535'],
        ];
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
