<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\Validator;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\Exceptions\HttpResponseException;

class StoreCierreRequest extends FormRequest
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

        $this->merge([
            'fecha' => $this->firstInput(['fecha', 'Fecha']),
            'tipo_cierre' => $this->firstInput([
                'tipo_cierre',
                'tipo de cierre',
                'tipoCierre',
                'Tipo_Cierre',
            ]),
            'estado_cierre' => $this->firstInput([
                'estado_cierre',
                'estado de cierre',
                'estadoCierre',
                'Estado_Cierre',
            ]),
            'codigos_propiedades' => $codigosPropiedades,
            'titulo' => $this->firstInput(['titulo', 'Titulo']),
            'precio_base' => $this->firstInput(['precio_base', 'precio base', 'Precio_Base']),
            'monto_cerrado' => $this->firstInput([
                'monto_cerrado',
                'monto cerrado',
                'Monto_Cerrado',
            ]),
            'id_cliente' => $this->firstInput([
                'id_cliente',
                'id cliente',
                'cliente_id',
                'Cliente_ID',
            ]),
            'ciudad' => $this->firstInput(['ciudad', 'Ciudad']),
            'nota' => $this->firstInput(['nota', 'Nota', 'nota_cierre']),
        ]);
    }

    public function rules(): array
    {
        return [
            'fecha' => ['required', 'date'],
            'tipo_cierre' => ['required', 'in:Venta,Alquiler,Remodelacion,asesoria,negocio'],
            'estado_cierre' => ['required', 'in:Inicial,terminado'],
            'codigos_propiedades' => ['nullable', 'array'],
            'codigos_propiedades.*' => ['nullable', 'string', 'max:120'],
            'titulo' => ['required', 'string', 'max:180'],
            'precio_base' => ['required', 'numeric', 'min:0'],
            'monto_cerrado' => ['required', 'numeric', 'min:0'],
            'id_cliente' => ['nullable', 'integer', 'min:1', 'exists:clientes,id_cliente'],
            'ciudad' => ['required', 'string', 'max:120'],
            'archivos' => ['nullable', 'array', 'max:10'],
            'archivos.*' => [
                'nullable',
                'file',
                'mimes:jpg,jpeg,png,webp,pdf,doc,docx,xls,xlsx,txt',
                'max:10240',
            ],
            'nota' => ['nullable', 'string', 'max:5000'],
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
