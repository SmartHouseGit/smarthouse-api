<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\Validator;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\Exceptions\HttpResponseException;

class SetPushConfigRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    protected function prepareForValidation(): void
    {
        $preDueDays = $this->firstInput(['preDueDays', 'pre_due_days']);
        if (is_string($preDueDays)) {
            $decoded = json_decode($preDueDays, true);
            if (is_array($decoded)) {
                $preDueDays = $decoded;
            } else {
                $preDueDays = array_values(array_filter(array_map(
                    static fn (string $part): int => (int) trim($part),
                    explode(',', $preDueDays)
                ), static fn (int $day): bool => $day > 0));
            }
        }

        $enabled = $this->normalizeBoolean($this->firstInput(['enabled']));
        $paused = $this->normalizeBoolean($this->firstInput(['paused']));

        $this->merge([
            'enabled' => $enabled,
            'paused' => $paused,
            'pauseUntil' => $this->firstInput(['pauseUntil', 'pause_until']),
            'pauseMinutes' => $this->firstInput(['pauseMinutes', 'pause_minutes']),
            'preDueDays' => $preDueDays,
            'preDueHour' => $this->firstInput(['preDueHour', 'pre_due_hour']),
            'dueMorningStartHour' => $this->firstInput(['dueMorningStartHour', 'due_morning_start_hour']),
            'dueMorningEndHour' => $this->firstInput(['dueMorningEndHour', 'due_morning_end_hour']),
            'dueAfternoonStartHour' => $this->firstInput(['dueAfternoonStartHour', 'due_afternoon_start_hour']),
            'dueAfternoonEndHour' => $this->firstInput(['dueAfternoonEndHour', 'due_afternoon_end_hour']),
            'spreadSeconds' => $this->firstInput(['spreadSeconds', 'spread_seconds']),
            'dispatchBatchSize' => $this->firstInput(['dispatchBatchSize', 'dispatch_batch_size']),
            'retryDelayMinutes' => $this->firstInput(['retryDelayMinutes', 'retry_delay_minutes']),
            'maxAttempts' => $this->firstInput(['maxAttempts', 'max_attempts']),
        ]);
    }

    public function rules(): array
    {
        return [
            'enabled' => ['sometimes', 'boolean'],
            'paused' => ['sometimes', 'boolean'],
            'pauseUntil' => ['sometimes', 'nullable', 'date'],
            'pauseMinutes' => ['sometimes', 'integer', 'min:1', 'max:43200'],
            'preDueDays' => ['sometimes', 'array'],
            'preDueDays.*' => ['integer', 'min:1', 'max:90'],
            'preDueHour' => ['sometimes', 'integer', 'min:0', 'max:23'],
            'dueMorningStartHour' => ['sometimes', 'integer', 'min:0', 'max:23'],
            'dueMorningEndHour' => ['sometimes', 'integer', 'min:0', 'max:23'],
            'dueAfternoonStartHour' => ['sometimes', 'integer', 'min:0', 'max:23'],
            'dueAfternoonEndHour' => ['sometimes', 'integer', 'min:0', 'max:23'],
            'spreadSeconds' => ['sometimes', 'integer', 'min:1', 'max:3600'],
            'dispatchBatchSize' => ['sometimes', 'integer', 'min:1', 'max:2000'],
            'retryDelayMinutes' => ['sometimes', 'integer', 'min:1', 'max:1440'],
            'maxAttempts' => ['sometimes', 'integer', 'min:1', 'max:20'],
        ];
    }

    public function withValidator($validator): void
    {
        $validator->after(function ($validator): void {
            $ms = $this->input('dueMorningStartHour');
            $me = $this->input('dueMorningEndHour');
            $as = $this->input('dueAfternoonStartHour');
            $ae = $this->input('dueAfternoonEndHour');

            if ($ms !== null && $me !== null && (int) $ms > (int) $me) {
                $validator->errors()->add('dueMorningEndHour', 'Debe ser mayor o igual al inicio de la manana.');
            }

            if ($as !== null && $ae !== null && (int) $as > (int) $ae) {
                $validator->errors()->add('dueAfternoonEndHour', 'Debe ser mayor o igual al inicio de la tarde.');
            }

            $hasAny = $this->hasAny([
                'enabled',
                'paused',
                'pauseUntil',
                'pauseMinutes',
                'preDueDays',
                'preDueHour',
                'dueMorningStartHour',
                'dueMorningEndHour',
                'dueAfternoonStartHour',
                'dueAfternoonEndHour',
                'spreadSeconds',
                'dispatchBatchSize',
                'retryDelayMinutes',
                'maxAttempts',
            ]);

            if (! $hasAny) {
                $validator->errors()->add('payload', 'Debes enviar al menos un campo de configuracion.');
            }
        });
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

    private function normalizeBoolean(mixed $value): mixed
    {
        if ($value === null) {
            return null;
        }

        if (is_bool($value)) {
            return $value;
        }

        if (is_string($value)) {
            $normalized = strtolower(trim($value));
            if (in_array($normalized, ['1', 'true', 'yes', 'on'], true)) {
                return true;
            }
            if (in_array($normalized, ['0', 'false', 'no', 'off'], true)) {
                return false;
            }
        }

        return $value;
    }
}
