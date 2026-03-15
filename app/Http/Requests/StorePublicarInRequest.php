<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\Validator;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\Exceptions\HttpResponseException;

class StorePublicarInRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    protected function prepareForValidation(): void
    {
        if (! $this->hasFile('imagen_referencial') && $this->hasFile('Imagen referencial del inmueble')) {
            $this->files->set('imagen_referencial', $this->file('Imagen referencial del inmueble'));
        }

        $this->merge([
            'nombre' => $this->input('nombre', $this->input('Nombre')),
            'telefono' => $this->input('telefono', $this->input('Telefono')),
            'ciudad' => $this->input('ciudad', $this->input('Ciudad')),
            'zona' => $this->input('zona', $this->input('Zona')),
            'tipo_inmueble' => $this->input(
                'tipo_inmueble',
                $this->input('Tipo de inmueble', $this->input('tipo de inmueble'))
            ),
            'mensaje' => $this->input('mensaje', $this->input('Mensaje')),
        ]);
    }

    public function rules(): array
    {
        return [
            'nombre' => ['required', 'string', 'max:150'],
            'telefono' => ['required', 'string', 'max:30'],
            'ciudad' => ['required', 'string', 'max:120'],
            'zona' => ['required', 'string', 'max:120'],
            'tipo_inmueble' => ['required', 'string', 'max:150'],
            'imagen_referencial' => ['required', 'file', 'image', 'mimes:jpg,jpeg,png,webp', 'max:5120'],
            'mensaje' => ['required', 'string', 'max:2000'],
        ];
    }

    protected function failedValidation(Validator $validator): void
    {
        throw new HttpResponseException(
            response()->json([
                'status' => 'ERROR',
                'message' => 'Validation failed',
                'errors' => $validator->errors(),
            ], 422)
        );
    }
}
