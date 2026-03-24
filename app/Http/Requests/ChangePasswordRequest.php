<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\Validator;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\Exceptions\HttpResponseException;

class ChangePasswordRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    protected function prepareForValidation(): void
    {
        $this->merge([
            'currentPassword' => $this->firstInput([
                'currentPassword',
                'current_password',
                'oldPassword',
                'old_password',
                'password_actual',
            ]),
            'newPassword' => $this->firstInput([
                'newPassword',
                'new_password',
                'password_new',
                'password_nueva',
            ]),
            'newPasswordConfirmation' => $this->firstInput([
                'newPasswordConfirmation',
                'new_password_confirmation',
                'confirmPassword',
                'confirm_password',
                'password_confirmation',
            ]),
        ]);
    }

    public function rules(): array
    {
        return [
            'currentPassword' => ['required', 'string', 'max:255'],
            'newPassword' => ['required', 'string', 'min:8', 'max:255', 'different:currentPassword'],
            'newPasswordConfirmation' => ['required', 'string', 'same:newPassword'],
        ];
    }

    protected function failedValidation(Validator $validator): void
    {
        throw new HttpResponseException(
            response()->json([
                'status' => 'ERROR',
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
