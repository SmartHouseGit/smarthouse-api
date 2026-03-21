<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\Validator;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\Exceptions\HttpResponseException;

class SendPushTestRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    protected function prepareForValidation(): void
    {
        $this->merge([
            'deviceId' => $this->firstInput(['deviceId', 'device_id', 'DeviceId']),
            'title' => $this->firstInput(['title', 'titulo', 'Titulo']),
            'body' => $this->firstInput(['body', 'mensaje', 'Mensaje']),
            'url' => $this->firstInput(['url', 'Url']),
        ]);
    }

    public function rules(): array
    {
        return [
            'deviceId' => ['required', 'string', 'max:120'],
            'title' => ['required', 'string', 'max:120'],
            'body' => ['required', 'string', 'max:300'],
            'url' => ['nullable', 'string', 'max:2000'],
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
