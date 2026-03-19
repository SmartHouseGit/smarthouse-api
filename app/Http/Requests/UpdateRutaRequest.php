<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\Validator;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\Exceptions\HttpResponseException;

class UpdateRutaRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    protected function prepareForValidation(): void
    {
        $resultados = $this->firstInput([
            'resultados',
            'Resultados',
            'lista_requisitos',
            'lista requisitos',
            'listaResultados',
        ]);

        if (is_string($resultados)) {
            $decoded = json_decode($resultados, true);
            if (is_array($decoded)) {
                $resultados = $decoded;
            }
        }

        $data = [];

        $idRuta = $this->firstInput(['id_ruta', 'idRuta', 'ruta_id']);
        $nota = $this->firstInput(['nota', 'notas', 'Nota', 'Notas']);

        if ($idRuta !== null) {
            $data['id_ruta'] = $idRuta;
        }
        if ($resultados !== null) {
            $data['resultados'] = $resultados;
        }
        if ($nota !== null) {
            $data['nota'] = $nota;
        }

        if ($data !== []) {
            $this->merge($data);
        }
    }

    public function rules(): array
    {
        return [
            'id_ruta' => ['required', 'integer', 'min:1', 'exists:rutas,id_ruta'],
            'resultados' => ['sometimes', 'nullable', 'array'],
            'nota' => ['sometimes', 'nullable', 'string', 'max:5000'],
        ];
    }

    public function withValidator($validator): void
    {
        $validator->after(function ($validator): void {
            $hasFields = $this->hasAny(['resultados', 'nota']);

            if (! $hasFields) {
                $validator->errors()->add('payload', 'Debe enviar al menos un campo para actualizar.');
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
