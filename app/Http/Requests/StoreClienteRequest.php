<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\Validator;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\Exceptions\HttpResponseException;

class StoreClienteRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    protected function prepareForValidation(): void
    {
        if (! $this->hasFile('foto') && $this->hasFile('Foto')) {
            $this->files->set('foto', $this->file('Foto'));
        }

        if (! $this->hasFile('portada') && $this->hasFile('Portada')) {
            $this->files->set('portada', $this->file('Portada'));
        }

        $this->merge([
            'foto' => $this->firstInput(['foto', 'Foto']),
            'portada' => $this->firstInput(['portada', 'Portada']),
            'nombre' => $this->firstInput(['nombre', 'Nombre']),
            'perfil' => $this->firstInput(['perfil', 'Perfil', 'descripcion', 'Descripcion']),
            'tipo' => $this->firstInput(['tipo', 'Tipo']),
            'estado' => $this->firstInput(['estado', 'Estado']),
            'telefono' => $this->firstInput(['telefono', 'Telefono']),
            'correo' => $this->firstInput(['correo', 'Correo', 'email', 'Email']),
            'direccion' => $this->firstInput(['direccion', 'Direccion']),
            'ciudad' => $this->firstInput(['ciudad', 'Ciudad']),
            'documento_rif' => $this->firstInput([
                'documento_rif',
                'documento/rif',
                'Documento_RIF',
                'Documento',
                'RIF',
            ]),
            'notas' => $this->firstInput(['notas', 'Notas']),
        ]);
    }

    public function rules(): array
    {
        return [
            'foto' => ['required', 'file', 'image', 'mimes:jpg,jpeg,png,webp', 'max:5120'],
            'portada' => ['required', 'file', 'image', 'mimes:jpg,jpeg,png,webp', 'max:5120'],
            'nombre' => ['required', 'string', 'max:180'],
            'perfil' => ['required', 'string', 'max:5000'],
            'tipo' => ['required', 'string', 'max:100'],
            'estado' => ['required', 'string', 'max:100'],
            'telefono' => ['required', 'string', 'max:40'],
            'correo' => ['required', 'email', 'max:180'],
            'direccion' => ['required', 'string', 'max:255'],
            'ciudad' => ['required', 'string', 'max:120'],
            'documento_rif' => ['required', 'string', 'max:60'],
            'notas' => ['nullable', 'string', 'max:5000'],
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
