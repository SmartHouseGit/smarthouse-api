<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\Validator;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\Exceptions\HttpResponseException;

class StoreSolicitarInRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    protected function prepareForValidation(): void
    {
        $datosEspecificos = $this->input(
            'datos_especificos',
            $this->input('Datos Especificos', $this->input('datosEspecificos'))
        );

        if (is_string($datosEspecificos)) {
            $decoded = json_decode($datosEspecificos, true);
            if (is_array($decoded)) {
                $datosEspecificos = $decoded;
            }
        }

        if (is_array($datosEspecificos)) {
            $datosEspecificos = array_filter([
                'numero_dormitorios' => $datosEspecificos['numero_dormitorios']
                    ?? $datosEspecificos['Numerod e dormitorios']
                    ?? $datosEspecificos['Numero de dormitorios']
                    ?? null,
                'cantidad_banos' => $datosEspecificos['cantidad_banos']
                    ?? $datosEspecificos['Cantidad de baños']
                    ?? $datosEspecificos['Cantidad de banos']
                    ?? null,
                'area_minima_m2' => $datosEspecificos['area_minima_m2']
                    ?? $datosEspecificos['Area minima en m2']
                    ?? null,
                'estacionamientos_minimos' => $datosEspecificos['estacionamientos_minimos']
                    ?? $datosEspecificos['Estacionamientos minimos?']
                    ?? null,
                'con_piscina' => $datosEspecificos['con_piscina']
                    ?? $datosEspecificos['Con piscina?']
                    ?? null,
                'pet_friendly' => $datosEspecificos['pet_friendly']
                    ?? $datosEspecificos['pet friendly']
                    ?? null,
            ], static fn ($value) => $value !== null);
        }

        if ($datosEspecificos === null || $datosEspecificos === '') {
            $datosEspecificos = [];
        }

        $this->merge([
            'nombre' => $this->input('nombre', $this->input('Nombre')),
            'telefono' => $this->input('telefono', $this->input('Telefono')),
            'ciudad' => $this->input('ciudad', $this->input('Ciudad')),
            'zona' => $this->input('zona', $this->input('Zona')),
            'tipo_inmueble' => $this->input(
                'tipo_inmueble',
                $this->input('Tipo de inmueble', $this->input('tipo de inmueble'))
            ),
            'presupuesto' => $this->input('presupuesto', $this->input('Presupuesto')),
            'mensaje' => $this->input('mensaje', $this->input('Mensaje')),
            'datos_especificos' => $datosEspecificos,
        ]);
    }

    public function rules(): array
    {
        return [
            'nombre' => ['required', 'string', 'max:150'],
            'telefono' => ['required', 'string', 'max:30'],
            'ciudad' => ['required', 'string', 'max:120'],
            'zona' => ['required', 'string', 'max:120'],
            'tipo_inmueble' => ['required', 'string', 'max:150'],
            'presupuesto' => ['required', 'numeric', 'min:0'],
            'mensaje' => ['required', 'string', 'max:2000'],
            'datos_especificos' => ['array'],
            'datos_especificos.numero_dormitorios' => ['nullable', 'integer', 'min:0'],
            'datos_especificos.cantidad_banos' => ['nullable', 'integer', 'min:0'],
            'datos_especificos.area_minima_m2' => ['nullable', 'numeric', 'min:0'],
            'datos_especificos.estacionamientos_minimos' => ['nullable', 'integer', 'min:0'],
            'datos_especificos.con_piscina' => ['nullable', 'boolean'],
            'datos_especificos.pet_friendly' => ['nullable', 'boolean'],
        ];
    }

    protected function failedValidation(Validator $validator): void
    {
        throw new HttpResponseException(
            response()->json(['status' => 'ERROR'], 422)
        );
    }
}
