<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\Validator;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\Exceptions\HttpResponseException;

class StoreLoanRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    protected function prepareForValidation(): void
    {
        $loanType = $this->normalizeLoanTypeInput($this->firstInput(['loanType', 'loan_type', 'type']));
        $ratePerCut = $this->firstInput(['ratePerCut', 'rate_per_cut']);

        if ($loanType === 'rent' && $ratePerCut === null) {
            $ratePerCut = 0;
        }

        $this->merge([
            'fullName' => $this->firstInput(['fullName', 'full_name', 'FullName']),
            'documentId' => $this->firstInput(['documentId', 'document_id', 'DocumentId']),
            'loanType' => $loanType,
            'principalUnit' => $this->firstInput(['principalUnit', 'principal_amount', 'principalAmount']),
            'cutFrequency' => $this->firstInput(['cutFrequency', 'cut_frequency']),
            'termValue' => $this->firstInput(['termValue', 'term_cuts', 'termCuts']),
            'ratePerCut' => $ratePerCut,
            'startDate' => $this->firstInput(['startDate', 'start_date']),
        ]);
    }

    public function rules(): array
    {
        return [
            'fullName' => ['required', 'string', 'max:180'],
            'documentId' => ['required', 'string', 'max:80'],
            'loanType' => ['nullable', 'in:loan,rent'],
            'principalUnit' => ['required', 'numeric', 'min:0.01'],
            'cutFrequency' => ['required', 'in:mensual,quincenal,semanal'],
            'termValue' => ['required', 'integer', 'min:1', 'max:360'],
            'ratePerCut' => ['required', 'numeric', 'min:0'],
            'startDate' => ['required', 'date_format:Y-m-d'],
        ];
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

    private function normalizeLoanTypeInput(mixed $loanType): ?string
    {
        if (! is_string($loanType) || trim($loanType) === '') {
            return null;
        }

        $normalized = mb_strtolower(trim($loanType));

        return match ($normalized) {
            'rent', 'alquiler' => 'rent',
            'loan', 'prestamo', 'préstamo' => 'loan',
            default => $loanType,
        };
    }
}
