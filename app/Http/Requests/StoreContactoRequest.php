<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\Validator;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\Exceptions\HttpResponseException;

class StoreContactoRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    protected function prepareForValidation(): void
    {
        $this->merge([
            'tipo' => $this->input('tipo', $this->input('Tipo')),
            'nombre' => $this->input('nombre', $this->input('Nombre')),
            'email' => $this->input('email', $this->input('Email')),
            'objetivo' => $this->input('objetivo', $this->input('Objetivo')),
            'mensaje' => $this->input('mensaje', $this->input('Mensaje')),
        ]);
    }

    public function rules(): array
    {
        return [
            'tipo' => ['required', 'integer', 'in:1,2'],
            'nombre' => ['required', 'string', 'max:150'],
            'email' => ['required', 'email', 'max:150'],
            'objetivo' => ['required', 'string', 'max:255'],
            'mensaje' => ['required', 'string', 'max:2000'],
        ];
    }

    protected function failedValidation(Validator $validator): void
    {
        throw new HttpResponseException(
            response()->json(['status' => 'ERROR'], 422)
        );
    }
}
