<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\Validator;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\Exceptions\HttpResponseException;

class UpdateClienteRequest extends FormRequest
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

        $data = [];

        $foto = $this->firstInput(['foto', 'Foto']);
        $portada = $this->firstInput(['portada', 'Portada']);
        $nombre = $this->firstInput(['nombre', 'Nombre']);
        $perfil = $this->firstInput(['perfil', 'Perfil', 'descripcion', 'Descripcion']);
        $tipo = $this->firstInput(['tipo', 'Tipo']);
        $estado = $this->firstInput(['estado', 'Estado']);
        $telefono = $this->firstInput(['telefono', 'Telefono']);
        $correo = $this->firstInput(['correo', 'Correo', 'email', 'Email']);
        $direccion = $this->firstInput(['direccion', 'Direccion']);
        $ciudad = $this->firstInput(['ciudad', 'Ciudad']);
        $documentoRif = $this->firstInput([
            'documento_rif',
            'documento/rif',
            'Documento_RIF',
            'Documento',
            'RIF',
        ]);
        $notas = $this->firstInput(['notas', 'Notas']);
        $agenteRes = $this->firstInput([
            'agente_res',
            'Agente_Res',
            'id_agente',
            'ID Agente',
        ]);

        if ($foto !== null) {
            $data['foto'] = $foto;
        }
        if ($portada !== null) {
            $data['portada'] = $portada;
        }
        if ($nombre !== null) {
            $data['nombre'] = $nombre;
        }
        if ($perfil !== null) {
            $data['perfil'] = $perfil;
        }
        if ($tipo !== null) {
            $data['tipo'] = $tipo;
        }
        if ($estado !== null) {
            $data['estado'] = $estado;
        }
        if ($telefono !== null) {
            $data['telefono'] = $telefono;
        }
        if ($correo !== null) {
            $data['correo'] = $correo;
        }
        if ($direccion !== null) {
            $data['direccion'] = $direccion;
        }
        if ($ciudad !== null) {
            $data['ciudad'] = $ciudad;
        }
        if ($documentoRif !== null) {
            $data['documento_rif'] = $documentoRif;
        }
        if ($notas !== null) {
            $data['notas'] = $notas;
        }
        if ($agenteRes !== null) {
            $data['agente_res'] = $agenteRes;
        }

        if ($data !== []) {
            $this->merge($data);
        }
    }

    public function rules(): array
    {
        return [
            'foto' => ['sometimes'],
            'portada' => ['sometimes'],
            'nombre' => ['sometimes', 'string', 'max:180'],
            'perfil' => ['sometimes', 'string', 'max:5000'],
            'tipo' => ['sometimes', 'string', 'max:100'],
            'estado' => ['sometimes', 'string', 'max:100'],
            'telefono' => ['sometimes', 'string', 'max:40'],
            'correo' => ['sometimes', 'email', 'max:180'],
            'direccion' => ['sometimes', 'string', 'max:255'],
            'ciudad' => ['sometimes', 'string', 'max:120'],
            'documento_rif' => ['sometimes', 'string', 'max:60'],
            'notas' => ['sometimes', 'nullable', 'string', 'max:5000'],
            'agente_res' => ['sometimes', 'integer', 'min:1', 'exists:agentes,id_agente'],
        ];
    }

    public function withValidator($validator): void
    {
        $validator->after(function ($validator): void {
            $hasFields = $this->hasAny([
                'foto',
                'portada',
                'nombre',
                'perfil',
                'tipo',
                'estado',
                'telefono',
                'correo',
                'direccion',
                'ciudad',
                'documento_rif',
                'notas',
                'agente_res',
            ]) || $this->hasFile('foto') || $this->hasFile('portada');

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
