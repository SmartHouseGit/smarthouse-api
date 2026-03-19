<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\Validator;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\Exceptions\HttpResponseException;

class UpdateReunionRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    protected function prepareForValidation(): void
    {
        $data = [];

        $idReunion = $this->firstInput(['id_reunion', 'idReunion', 'reunion_id']);
        $titulo = $this->firstInput(['titulo', 'Titulo', 'titulo_reunion']);
        $fecha = $this->firstInput(['fecha', 'Fecha']);
        $hora = $this->firstInput(['hora', 'Hora']);
        $lugar = $this->firstInput(['lugar', 'Lugar']);
        $idCliente = $this->firstInput([
            'id_cliente',
            'cliente_asociado',
            'cliente_id',
            'Cliente_ID',
        ]);
        $notas = $this->firstInput(['notas', 'nota', 'Notas', 'Nota']);
        $ref = $this->firstInput(['ref', 'Ref']);
        $mod = $this->firstInput(['mod', 'Mod']);
        $estado = $this->firstInput(['estado', 'Estado']);

        if (is_string($mod)) {
            $normalized = strtolower(trim($mod));
            if (in_array($normalized, ['true', '1', 'si', 'sí'], true)) {
                $mod = true;
            } elseif (in_array($normalized, ['false', '0', 'no'], true)) {
                $mod = false;
            }
        }

        if ($idReunion !== null) {
            $data['id_reunion'] = $idReunion;
        }
        if ($titulo !== null) {
            $data['titulo'] = $titulo;
        }
        if ($fecha !== null) {
            $data['fecha'] = $fecha;
        }
        if ($hora !== null) {
            $data['hora'] = $hora;
        }
        if ($lugar !== null) {
            $data['lugar'] = $lugar;
        }
        if ($idCliente !== null) {
            $data['id_cliente'] = $idCliente;
        }
        if ($notas !== null) {
            $data['notas'] = $notas;
        }
        if ($ref !== null) {
            $data['ref'] = $ref;
        }
        if ($mod !== null) {
            $data['mod'] = $mod;
        }
        if ($estado !== null) {
            $data['estado'] = $estado;
        }

        if ($data !== []) {
            $this->merge($data);
        }
    }

    public function rules(): array
    {
        return [
            'id_reunion' => ['required', 'integer', 'min:1', 'exists:reuniones,id_reunion'],
            'titulo' => ['sometimes', 'string', 'max:200'],
            'fecha' => ['sometimes', 'date'],
            'hora' => ['sometimes', 'regex:/^\\d{2}:\\d{2}(:\\d{2})?$/'],
            'lugar' => ['sometimes', 'string', 'max:255'],
            'id_cliente' => ['sometimes', 'nullable', 'integer', 'min:1', 'exists:clientes,id_cliente'],
            'notas' => ['sometimes', 'nullable', 'string', 'max:5000'],
            'ref' => ['sometimes', 'nullable', 'integer', 'min:1'],
            'mod' => ['sometimes', 'boolean'],
            'estado' => ['sometimes', 'nullable', 'string', 'max:120'],
        ];
    }

    public function withValidator($validator): void
    {
        $validator->after(function ($validator): void {
            $hasFields = $this->hasAny([
                'titulo',
                'fecha',
                'hora',
                'lugar',
                'id_cliente',
                'notas',
                'ref',
                'mod',
                'estado',
            ]);

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
