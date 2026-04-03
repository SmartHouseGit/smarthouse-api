<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\Validator;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\Exceptions\HttpResponseException;

class UpdateSolEstadoRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    protected function prepareForValidation(): void
    {
        $this->merge([
            'tipo' => $this->normalizeTipo($this->firstInput(['tipo', 'Tipo'])),
            'id_registro' => $this->firstInput(['id_registro', 'idRegistro', 'registro_id']),
            'estado' => $this->firstInput(['estado', 'Estado']),
        ]);
    }

    public function rules(): array
    {
        return [
            'tipo' => ['required', 'string', 'in:cont,SolIn,PubIn'],
            'id_registro' => ['required', 'integer', 'min:1'],
            'estado' => ['present', 'nullable', 'string', 'max:120'],
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

    private function normalizeTipo(mixed $value): mixed
    {
        if ($value === null) {
            return null;
        }

        $normalized = strtolower(str_replace([' ', '_', '-'], '', trim((string) $value)));

        return match ($normalized) {
            'cont', 'contacto', 'contactos' => 'cont',
            'solin', 'solicitarin', 'solicitarins', 'solicitar' => 'SolIn',
            'pubin', 'publicarin', 'publicarins', 'publicar' => 'PubIn',
            default => $value,
        };
    }
}
