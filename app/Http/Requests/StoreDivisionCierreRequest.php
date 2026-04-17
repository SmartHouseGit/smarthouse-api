<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\Validator;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\Exceptions\HttpResponseException;

class StoreDivisionCierreRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    protected function prepareForValidation(): void
    {
        $participantes = $this->firstInput([
            'participantes',
            'Participantes',
        ]);

        if (is_string($participantes)) {
            $decoded = json_decode($participantes, true);
            if (is_array($decoded)) {
                $participantes = $decoded;
            }
        }

        $tipoAfiliacion = $this->firstInput([
            'tipo_afiliacion',
            'tipoAfiliacion',
            'tipo afiliacion',
            'tipo_af',
        ]);

        if (is_string($tipoAfiliacion)) {
            $tipoAfiliacion = mb_strtolower(trim($tipoAfiliacion));
        }

        $this->merge([
            'id_cierre' => $this->firstInput(['id_cierre', 'id cierre']),
            'id_propiedad' => $this->firstInput(['id_propiedad', 'id propiedad']),
            'tipo_afiliacion' => $tipoAfiliacion,
            'participantes' => $participantes,
        ]);
    }

    public function rules(): array
    {
        return [
            'id_cierre' => ['required', 'integer', 'min:1', 'exists:cierres,id_cierre'],
            'id_propiedad' => ['required', 'integer', 'min:1', 'exists:propiedades,id_interno'],
            'tipo_afiliacion' => ['required', 'in:ninguna,interna,externa'],
            'participantes' => ['required', 'array', 'min:1'],
            'participantes.*' => ['required', 'string', 'max:40'],
        ];
    }

    public function withValidator($validator): void
    {
        $validator->after(function ($validator): void {
            $participantes = $this->input('participantes');
            if (! is_array($participantes)) {
                return;
            }

            foreach ($participantes as $nombreOEmail => $rol) {
                if (is_int($nombreOEmail) || trim((string) $nombreOEmail) === '') {
                    $validator->errors()->add('participantes', 'Participantes debe ser un objeto JSON con nombre/correo como clave.');
                    return;
                }

                if (! is_string($rol) || trim($rol) === '') {
                    $validator->errors()->add('participantes.'.$nombreOEmail, 'El rol del participante es obligatorio.');
                    return;
                }
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
