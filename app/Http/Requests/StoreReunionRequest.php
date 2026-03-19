<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\Validator;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\Exceptions\HttpResponseException;

class StoreReunionRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    protected function prepareForValidation(): void
    {
        $mod = $this->firstInput(['mod', 'Mod']);

        if (is_string($mod)) {
            $normalized = strtolower(trim($mod));
            if (in_array($normalized, ['true', '1', 'si', 'sí'], true)) {
                $mod = true;
            } elseif (in_array($normalized, ['false', '0', 'no'], true)) {
                $mod = false;
            }
        }

        $this->merge([
            'titulo' => $this->firstInput(['titulo', 'Titulo', 'titulo_reunion']),
            'fecha' => $this->firstInput(['fecha', 'Fecha']),
            'hora' => $this->firstInput(['hora', 'Hora']),
            'lugar' => $this->firstInput(['lugar', 'Lugar']),
            'id_cliente' => $this->firstInput([
                'id_cliente',
                'cliente_asociado',
                'cliente_id',
                'Cliente_ID',
            ]),
            'notas' => $this->firstInput(['notas', 'nota', 'Notas', 'Nota']),
            'ref' => $this->firstInput(['ref', 'Ref']),
            'mod' => $mod,
            'estado' => $this->firstInput(['estado', 'Estado']),
        ]);
    }

    public function rules(): array
    {
        return [
            'titulo' => ['required', 'string', 'max:200'],
            'fecha' => ['required', 'date'],
            'hora' => ['required', 'regex:/^\\d{2}:\\d{2}(:\\d{2})?$/'],
            'lugar' => ['required', 'string', 'max:255'],
            'id_cliente' => ['nullable', 'integer', 'min:1', 'exists:clientes,id_cliente'],
            'notas' => ['nullable', 'string', 'max:5000'],
            'ref' => ['nullable', 'integer', 'min:1'],
            'mod' => ['required', 'boolean'],
            'estado' => ['nullable', 'string', 'max:120'],
        ];
    }

    public function withValidator(\Illuminate\Validation\Validator $validator): void
    {
        $validator->after(function (\Illuminate\Validation\Validator $validator): void {
            $mod = filter_var($this->input('mod'), FILTER_VALIDATE_BOOL, FILTER_NULL_ON_FAILURE);
            $ref = $this->input('ref');

            if ($mod === false && ($ref === null || $ref === '')) {
                $validator->errors()->add('ref', 'The ref field is required when mod is false.');
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
