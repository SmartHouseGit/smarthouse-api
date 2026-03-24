<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\Validator;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\Exceptions\HttpResponseException;

class UpdateLoanDataRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    protected function prepareForValidation(): void
    {
        $fullName = $this->firstInput(['fullName', 'full_name']);
        $documentId = $this->firstInput(['documentId', 'document_id']);
        $status = $this->firstInput(['status']);

        $payload = [];

        if ($fullName !== null) {
            $payload['fullName'] = $fullName;
        }

        if ($documentId !== null) {
            $payload['documentId'] = $documentId;
        }

        if ($status !== null) {
            $payload['status'] = $status;
        }

        if ($payload !== []) {
            $this->merge($payload);
        }
    }

    public function rules(): array
    {
        return [
            'fullName' => ['sometimes', 'string', 'max:180'],
            'documentId' => ['sometimes', 'string', 'max:80'],
            'status' => ['sometimes', 'in:active,completed,cancelled'],
        ];
    }

    public function withValidator($validator): void
    {
        $validator->after(function ($validator): void {
            $hasAny = $this->hasAny(['fullName', 'documentId', 'status']);

            if (! $hasAny) {
                $validator->errors()->add('payload', 'Debe enviar al menos un campo del prestamo para actualizar.');
            }
        });
    }

    protected function failedValidation(Validator $validator): void
    {
        throw new HttpResponseException(
            response()->json([
                'ok' => false,
                'message' => 'Validation error',
                'errors' => $validator->errors(),
            ], 422)
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
