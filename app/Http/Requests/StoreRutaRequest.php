<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\Validator;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\Exceptions\HttpResponseException;

class StoreRutaRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    protected function prepareForValidation(): void
    {
        $sectores = $this->firstInput(['sectores', 'Sectores']);
        $recaudos = $this->firstInput(['recaudos', 'Recaudos']);
        $ubicacionInicial = $this->firstInput([
            'ubicacion_inicial',
            'ubicacion inicial',
            'ubicacionInicial',
            'Ubicacion_Inicial',
        ]);

        if (is_string($sectores)) {
            $decoded = json_decode($sectores, true);
            if (is_array($decoded)) {
                $sectores = $decoded;
            }
        }

        if (is_string($recaudos)) {
            $decoded = json_decode($recaudos, true);
            if (is_array($decoded)) {
                $recaudos = $decoded;
            }
        }

        if (is_string($ubicacionInicial)) {
            $decoded = json_decode($ubicacionInicial, true);
            if (is_array($decoded)) {
                $ubicacionInicial = $decoded;
            }
        }

        if (is_array($ubicacionInicial)) {
            if (! array_key_exists('lat', $ubicacionInicial)) {
                if (array_key_exists('latitud', $ubicacionInicial)) {
                    $ubicacionInicial['lat'] = $ubicacionInicial['latitud'];
                } elseif (array_key_exists('latitude', $ubicacionInicial)) {
                    $ubicacionInicial['lat'] = $ubicacionInicial['latitude'];
                }
            }

            if (! array_key_exists('lng', $ubicacionInicial)) {
                if (array_key_exists('longitud', $ubicacionInicial)) {
                    $ubicacionInicial['lng'] = $ubicacionInicial['longitud'];
                } elseif (array_key_exists('longitude', $ubicacionInicial)) {
                    $ubicacionInicial['lng'] = $ubicacionInicial['longitude'];
                } elseif (array_key_exists('lon', $ubicacionInicial)) {
                    $ubicacionInicial['lng'] = $ubicacionInicial['lon'];
                }
            }
        }

        $this->merge([
            'zona' => $this->firstInput(['zona', 'Zona']),
            'hora_inicio' => $this->firstInput(['hora_inicio', 'hora inicio', 'horaInicio', 'Hora_Inicio']),
            'hora_final' => $this->firstInput(['hora_final', 'hora final', 'horaFinal', 'Hora_Final']),
            'sectores' => $sectores,
            'ubicacion_inicial' => $ubicacionInicial,
            'recaudos' => $recaudos,
        ]);
    }

    public function rules(): array
    {
        return [
            'zona' => ['required', 'string', 'max:180'],
            'hora_inicio' => ['required', 'regex:/^\\d{2}:\\d{2}(:\\d{2})?$/'],
            'hora_final' => ['required', 'regex:/^\\d{2}:\\d{2}(:\\d{2})?$/'],
            'sectores' => ['required', 'array', 'min:1'],
            'sectores.*' => ['nullable', 'string', 'max:180'],
            'ubicacion_inicial' => ['required', 'array'],
            'ubicacion_inicial.lat' => ['required', 'numeric', 'between:-90,90'],
            'ubicacion_inicial.lng' => ['required', 'numeric', 'between:-180,180'],
            'recaudos' => ['required', 'array', 'min:1'],
            'recaudos.*' => ['nullable', 'string', 'max:500'],
        ];
    }

    public function withValidator($validator): void
    {
        $validator->after(function ($validator): void {
            $horaInicio = $this->input('hora_inicio');
            $horaFinal = $this->input('hora_final');

            if (! is_string($horaInicio) || ! is_string($horaFinal)) {
                return;
            }

            $inicio = strtotime('1970-01-01 '.$horaInicio);
            $final = strtotime('1970-01-01 '.$horaFinal);

            if ($inicio === false || $final === false) {
                return;
            }

            if ($final <= $inicio) {
                $validator->errors()->add('hora_final', 'hora_final debe ser mayor que hora_inicio.');
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
