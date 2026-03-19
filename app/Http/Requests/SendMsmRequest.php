<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\Validator;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\Exceptions\HttpResponseException;

class SendMsmRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    protected function prepareForValidation(): void
    {
        $full = $this->firstInput(['full', 'Full']);

        if (is_string($full)) {
            $normalized = strtolower(trim($full));
            if (in_array($normalized, ['true', '1', 'si', 'sí'], true)) {
                $full = true;
            } elseif (in_array($normalized, ['false', '0', 'no'], true)) {
                $full = false;
            }
        }

        $agentes = $this->firstInput(['agentes', 'Agentes']);
        if (is_string($agentes)) {
            $decoded = json_decode($agentes, true);
            if (is_array($decoded)) {
                $agentes = $decoded;
            }
        }

        $this->merge([
            'sender' => $this->firstInput(['sender', 'Sender']),
            'full' => $full,
            'agentes' => $agentes,
            'prioridad' => $this->firstInput(['prioridad', 'Prioridad']),
            'titulo' => $this->firstInput(['titulo', 'Titulo']),
            'mensaje' => $this->firstInput(['mensaje', 'Mensaje']),
        ]);
    }

    public function rules(): array
    {
        return [
            'sender' => ['required', 'integer', 'min:1', 'exists:users,id'],
            'full' => ['required', 'boolean'],
            'agentes' => ['sometimes', 'array'],
            'agentes.*' => ['nullable', 'integer', 'min:1', 'exists:agentes,id_agente'],
            'prioridad' => ['required', 'in:baja,media,alta,urgente'],
            'titulo' => ['required', 'string', 'max:220'],
            'mensaje' => ['required', 'string', 'max:10000'],
        ];
    }

    public function withValidator($validator): void
    {
        $validator->after(function ($validator): void {
            $full = filter_var($this->input('full'), FILTER_VALIDATE_BOOL, FILTER_NULL_ON_FAILURE);
            $agentes = $this->input('agentes');

            if ($full === false) {
                if (! is_array($agentes) || $agentes === []) {
                    $validator->errors()->add('agentes', 'Debe enviar al menos un agente cuando full es false.');
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
