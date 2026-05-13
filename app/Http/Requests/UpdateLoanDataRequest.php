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
        $principalUnit = $this->firstInput(['principalUnit', 'principal_amount', 'principalAmount']);
        $cutFrequency = $this->firstInput(['cutFrequency', 'cut_frequency']);
        $termValue = $this->firstInput(['termValue', 'term_cuts', 'termCuts']);
        $ratePerCut = $this->firstInput(['ratePerCut', 'rate_per_cut']);
        $startDate = $this->firstInput(['startDate', 'start_date']);
        $afecta = $this->firstInput(['afecta', 'affectsPaid', 'affects_paid']);

        if (is_string($afecta)) {
            $normalizedAfecta = mb_strtolower(trim($afecta));
            if (in_array($normalizedAfecta, ['true', '1', 'yes', 'si'], true)) {
                $afecta = true;
            } elseif (in_array($normalizedAfecta, ['false', '0', 'no'], true)) {
                $afecta = false;
            }
        }

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

        if ($principalUnit !== null) {
            $payload['principalUnit'] = $principalUnit;
        }

        if ($cutFrequency !== null) {
            $payload['cutFrequency'] = $cutFrequency;
        }

        if ($termValue !== null) {
            $payload['termValue'] = $termValue;
        }

        if ($ratePerCut !== null) {
            $payload['ratePerCut'] = $ratePerCut;
        }

        if ($startDate !== null) {
            $payload['startDate'] = $startDate;
        }

        if ($afecta !== null) {
            $payload['afecta'] = $afecta;
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
            'principalUnit' => ['sometimes', 'numeric', 'min:0.01'],
            'cutFrequency' => ['sometimes', 'in:mensual,quincenal,semanal'],
            'termValue' => ['sometimes', 'integer', 'min:1', 'max:360'],
            'ratePerCut' => ['sometimes', 'numeric', 'min:0'],
            'startDate' => ['sometimes', 'date_format:Y-m-d'],
            'afecta' => ['sometimes', 'boolean'],
        ];
    }

    public function withValidator($validator): void
    {
        $validator->after(function ($validator): void {
            $hasAny = $this->hasAny([
                'fullName',
                'documentId',
                'status',
                'principalUnit',
                'cutFrequency',
                'termValue',
                'ratePerCut',
                'startDate',
                'afecta',
            ]);

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
