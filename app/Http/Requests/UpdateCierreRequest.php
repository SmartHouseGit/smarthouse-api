<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\Validator;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\Exceptions\HttpResponseException;

class UpdateCierreRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    protected function prepareForValidation(): void
    {
        if (! $this->hasFile('archivos') && $this->hasFile('Archivos')) {
            $this->files->set('archivos', $this->file('Archivos'));
        }

        if ($this->hasFile('archivos')) {
            $files = $this->file('archivos');
            if (! is_array($files)) {
                $this->files->set('archivos', [$files]);
            }
        }

        $codigosPropiedades = $this->firstInput([
            'codigos_propiedades',
            'codigosPropiedades',
            'codigos',
            'Codigos',
        ]);

        if (is_string($codigosPropiedades)) {
            $decoded = json_decode($codigosPropiedades, true);
            if (is_array($decoded)) {
                $codigosPropiedades = $decoded;
            } elseif ($codigosPropiedades !== '') {
                $codigosPropiedades = [$codigosPropiedades];
            }
        }

        $data = [];

        $idCierre = $this->firstInput(['id_cierre', 'idCierre', 'cierre_id']);
        $fecha = $this->firstInput(['fecha', 'Fecha']);
        $tipoCierre = $this->firstInput([
            'tipo_cierre',
            'tipo de cierre',
            'tipoCierre',
            'Tipo_Cierre',
        ]);
        $estadoCierre = $this->firstInput([
            'estado_cierre',
            'estado de cierre',
            'estadoCierre',
            'Estado_Cierre',
        ]);
        $titulo = $this->firstInput(['titulo', 'Titulo']);
        $precioBase = $this->firstInput(['precio_base', 'precio base', 'Precio_Base']);
        $montoCerrado = $this->firstInput([
            'monto_cerrado',
            'monto cerrado',
            'Monto_Cerrado',
        ]);
        $idCliente = $this->firstInput([
            'id_cliente',
            'id cliente',
            'cliente_id',
            'Cliente_ID',
        ]);
        $ciudad = $this->firstInput(['ciudad', 'Ciudad']);
        $nota = $this->firstInput(['nota', 'Nota', 'nota_cierre']);
        $ref = $this->firstInput(['ref', 'Ref', 'id_agente']);

        if ($idCierre !== null) {
            $data['id_cierre'] = $idCierre;
        }
        if ($fecha !== null) {
            $data['fecha'] = $fecha;
        }
        if ($tipoCierre !== null) {
            $data['tipo_cierre'] = $tipoCierre;
        }
        if ($estadoCierre !== null) {
            $data['estado_cierre'] = $estadoCierre;
        }
        if ($codigosPropiedades !== null) {
            $data['codigos_propiedades'] = $codigosPropiedades;
        }
        if ($titulo !== null) {
            $data['titulo'] = $titulo;
        }
        if ($precioBase !== null) {
            $data['precio_base'] = $precioBase;
        }
        if ($montoCerrado !== null) {
            $data['monto_cerrado'] = $montoCerrado;
        }
        if ($idCliente !== null) {
            $data['id_cliente'] = $idCliente;
        }
        if ($ciudad !== null) {
            $data['ciudad'] = $ciudad;
        }
        if ($nota !== null) {
            $data['nota'] = $nota;
        }
        if ($ref !== null) {
            $data['ref'] = $ref;
        }

        if ($data !== []) {
            $this->merge($data);
        }
    }

    public function rules(): array
    {
        return [
            'id_cierre' => ['required', 'integer', 'min:1', 'exists:cierres,id_cierre'],
            'fecha' => ['sometimes', 'date'],
            'tipo_cierre' => ['sometimes', 'in:Venta,Alquiler,Remodelacion,asesoria,negocio'],
            'estado_cierre' => ['sometimes', 'in:Inicial,terminado'],
            'codigos_propiedades' => ['sometimes', 'nullable', 'array'],
            'codigos_propiedades.*' => ['nullable', 'string', 'max:120'],
            'titulo' => ['sometimes', 'string', 'max:180'],
            'precio_base' => ['sometimes', 'numeric', 'min:0'],
            'monto_cerrado' => ['sometimes', 'numeric', 'min:0'],
            'id_cliente' => ['sometimes', 'nullable', 'integer', 'min:1', 'exists:clientes,id_cliente'],
            'ciudad' => ['sometimes', 'string', 'max:120'],
            'archivos' => ['sometimes', 'nullable', 'array', 'max:10'],
            'archivos.*' => [
                'nullable',
                'file',
                'mimes:jpg,jpeg,png,webp,pdf,doc,docx,xls,xlsx,txt',
                'max:10240',
            ],
            'nota' => ['sometimes', 'nullable', 'string', 'max:5000'],
            'ref' => ['sometimes', 'integer', 'min:1'],
        ];
    }

    public function withValidator($validator): void
    {
        $validator->after(function ($validator): void {
            $hasFields = $this->hasAny([
                'fecha',
                'tipo_cierre',
                'estado_cierre',
                'codigos_propiedades',
                'titulo',
                'precio_base',
                'monto_cerrado',
                'id_cliente',
                'ciudad',
                'nota',
                'ref',
            ]) || $this->hasFile('archivos');

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
