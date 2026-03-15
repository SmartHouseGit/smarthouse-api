<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\Validator;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\Exceptions\HttpResponseException;

class StoreAgenteRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    protected function prepareForValidation(): void
    {
        if (! $this->hasFile('foto_portada') && $this->hasFile('Foto_Portada')) {
            $this->files->set('foto_portada', $this->file('Foto_Portada'));
        }

        if (! $this->hasFile('foto_perfil') && $this->hasFile('Foto_Perfil')) {
            $this->files->set('foto_perfil', $this->file('Foto_Perfil'));
        }

        $this->merge([
            'foto_portada' => $this->firstInput(['foto_portada', 'Foto_Portada', 'Foto de portada']),
            'foto_perfil' => $this->firstInput(['foto_perfil', 'Foto_Perfil', 'Foto de perfil']),
            'nombre' => $this->firstInput(['nombre', 'Nombre']),
            'apellido' => $this->firstInput(['apellido', 'Apellido']),
            'telefono' => $this->firstInput(['telefono', 'Telefono']),
            'descripcion_breve' => $this->firstInput([
                'descripcion_breve',
                'Descripcion breve',
                'descripcion breve',
            ]),
        ]);
    }

    public function rules(): array
    {
        return [
            'foto_portada' => ['required', 'file', 'image', 'mimes:jpg,jpeg,png,webp', 'max:5120'],
            'foto_perfil' => ['required', 'file', 'image', 'mimes:jpg,jpeg,png,webp', 'max:5120'],
            'nombre' => ['required', 'string', 'max:120'],
            'apellido' => ['required', 'string', 'max:120'],
            'telefono' => ['required', 'string', 'max:40'],
            'descripcion_breve' => ['required', 'string', 'max:2000'],
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
