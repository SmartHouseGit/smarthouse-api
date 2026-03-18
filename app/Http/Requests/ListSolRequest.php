<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\Validator;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\Exceptions\HttpResponseException;

class ListSolRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    protected function prepareForValidation(): void
    {
        $this->merge([
            'tipo' => $this->normalizeTipo($this->firstInput(['tipo', 'Tipo'])),
            'filter' => $this->normalizeBoolean($this->firstInput(['filter', 'Filter'])),
        ]);
    }

    public function rules(): array
    {
        return [
            'tipo' => ['required', 'string', 'in:cont,SolIn,PubIn,all'],
            'filter' => ['nullable', 'boolean'],
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
            'all', 'todo' => 'all',
            default => $value,
        };
    }

    private function normalizeBoolean(mixed $value): mixed
    {
        if ($value === null || is_bool($value)) {
            return $value;
        }

        if (is_numeric($value)) {
            return (int) $value === 1;
        }

        $normalized = strtolower(trim((string) $value));

        if (in_array($normalized, ['true', '1', 'yes', 'si'], true)) {
            return true;
        }

        if (in_array($normalized, ['false', '0', 'no'], true)) {
            return false;
        }

        return $value;
    }
}
