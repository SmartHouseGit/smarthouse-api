<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\Validator;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\Exceptions\HttpResponseException;

class UpdateLoanRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    protected function prepareForValidation(): void
    {
        $action = $this->firstInput(['action']);
        $fullName = $this->firstInput(['fullName', 'full_name']);
        $documentId = $this->firstInput(['documentId', 'document_id']);
        $status = $this->firstInput(['status']);
        $cutId = $this->firstInput(['cutId', 'cut_id']);
        $days = $this->firstInput(['days']);
        $penaltyPercent = $this->firstInput(['penaltyPercent', 'penalty_percent']);
        $note = $this->firstInput(['note']);

        $payload = [];

        if ($action !== null) {
            $payload['action'] = $action;
        }

        if ($fullName !== null) {
            $payload['fullName'] = $fullName;
        }

        if ($documentId !== null) {
            $payload['documentId'] = $documentId;
        }

        if ($status !== null) {
            $payload['status'] = $status;
        }

        if ($cutId !== null) {
            $payload['cutId'] = $cutId;
        }

        if ($days !== null) {
            $payload['days'] = $days;
        }

        if ($penaltyPercent !== null) {
            $payload['penaltyPercent'] = $penaltyPercent;
        }

        if ($note !== null) {
            $payload['note'] = $note;
        }

        if ($payload !== []) {
            $this->merge($payload);
        }
    }

    public function rules(): array
    {
        return [
            'action' => ['required', 'in:update_loan,pay_cut,extend_cut,penalize_cut'],
            'fullName' => ['sometimes', 'nullable', 'string', 'max:180'],
            'documentId' => ['sometimes', 'nullable', 'string', 'max:80'],
            'status' => ['sometimes', 'nullable', 'in:active,completed,cancelled'],
            'cutId' => ['sometimes', 'nullable', 'integer', 'min:1'],
            'days' => ['sometimes', 'nullable', 'integer', 'min:1', 'max:365'],
            'penaltyPercent' => ['sometimes', 'nullable', 'numeric', 'min:0', 'max:1000'],
            'note' => ['sometimes', 'nullable', 'string', 'max:5000'],
            'proof' => ['sometimes', 'file', 'mimes:jpg,jpeg,png,webp,pdf', 'max:8192'],
        ];
    }

    public function withValidator($validator): void
    {
        $validator->after(function ($validator): void {
            $action = $this->input('action');

            if ($action === 'update_loan') {
                $hasAny = $this->hasAny(['fullName', 'documentId', 'status']);
                if (! $hasAny) {
                    $validator->errors()->add('payload', 'Debe enviar al menos un campo para update_loan.');
                }
            }

            if ($action === 'pay_cut') {
                if (! $this->filled('cutId')) {
                    $validator->errors()->add('cutId', 'cutId es requerido para pay_cut.');
                }
            }

            if ($action === 'extend_cut') {
                if (! $this->filled('cutId')) {
                    $validator->errors()->add('cutId', 'cutId es requerido para extend_cut.');
                }
                if (! $this->filled('days')) {
                    $validator->errors()->add('days', 'days es requerido para extend_cut.');
                }
            }

            if ($action === 'penalize_cut') {
                if (! $this->filled('cutId')) {
                    $validator->errors()->add('cutId', 'cutId es requerido para penalize_cut.');
                }
                if (! $this->filled('penaltyPercent')) {
                    $validator->errors()->add('penaltyPercent', 'penaltyPercent es requerido para penalize_cut.');
                }
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
