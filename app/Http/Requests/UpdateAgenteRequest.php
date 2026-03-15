<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\Validator;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\Exceptions\HttpResponseException;

class UpdateAgenteRequest extends FormRequest
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

        $data = [];

        $fotoPortada = $this->firstInput(['foto_portada', 'Foto_Portada', 'Foto de portada']);
        $fotoPerfil = $this->firstInput(['foto_perfil', 'Foto_Perfil', 'Foto de perfil']);
        $nombre = $this->firstInput(['nombre', 'Nombre']);
        $apellido = $this->firstInput(['apellido', 'Apellido']);
        $telefono = $this->firstInput(['telefono', 'Telefono']);
        $descripcionBreve = $this->firstInput([
            'descripcion_breve',
            'Descripcion breve',
            'descripcion breve',
        ]);

        if ($fotoPortada !== null) {
            $data['foto_portada'] = $fotoPortada;
        }
        if ($fotoPerfil !== null) {
            $data['foto_perfil'] = $fotoPerfil;
        }
        if ($nombre !== null) {
            $data['nombre'] = $nombre;
        }
        if ($apellido !== null) {
            $data['apellido'] = $apellido;
        }
        if ($telefono !== null) {
            $data['telefono'] = $telefono;
        }
        if ($descripcionBreve !== null) {
            $data['descripcion_breve'] = $descripcionBreve;
        }

        if ($data !== []) {
            $this->merge($data);
        }
    }

    public function rules(): array
    {
        return [
            'foto_portada' => ['sometimes', 'file', 'image', 'mimes:jpg,jpeg,png,webp', 'max:5120'],
            'foto_perfil' => ['sometimes', 'file', 'image', 'mimes:jpg,jpeg,png,webp', 'max:5120'],
            'nombre' => ['sometimes', 'string', 'max:120'],
            'apellido' => ['sometimes', 'string', 'max:120'],
            'telefono' => ['sometimes', 'string', 'max:40'],
            'descripcion_breve' => ['sometimes', 'string', 'max:2000'],
        ];
    }

    public function withValidator($validator): void
    {
        $validator->after(function ($validator): void {
            $hasFields = $this->hasAny([
                'foto_portada',
                'foto_perfil',
                'nombre',
                'apellido',
                'telefono',
                'descripcion_breve',
            ]) || $this->hasFile('foto_portada') || $this->hasFile('foto_perfil');

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
