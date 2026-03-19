<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\Validator;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\Exceptions\HttpResponseException;

class SetConfigRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    protected function prepareForValidation(): void
    {
        if (! $this->hasFile('hero_imagen') && $this->hasFile('heroImagen')) {
            $this->files->set('hero_imagen', $this->file('heroImagen'));
        }

        if (! $this->hasFile('hero_imagen') && $this->hasFile('hero_image')) {
            $this->files->set('hero_imagen', $this->file('hero_image'));
        }

        if (! $this->hasFile('banner') && $this->hasFile('Banner')) {
            $this->files->set('banner', $this->file('Banner'));
        }

        if ($this->hasFile('banner')) {
            $files = $this->file('banner');
            if (! is_array($files)) {
                $this->files->set('banner', [$files]);
            }
        }

        $heroFrase = $this->firstInput([
            'hero_frase',
            'heroFrase',
            'frase_hero',
            'hero_texto',
        ]);

        $hero = $this->firstInput(['hero', 'Hero']);
        if (is_string($hero)) {
            $decoded = json_decode($hero, true);
            if (is_array($decoded)) {
                $hero = $decoded;
            }
        }

        if (is_array($hero) && $heroFrase === null) {
            $heroFrase = $hero['frase'] ?? $hero['texto'] ?? $hero['title'] ?? null;
        }

        $micelines = $this->firstInput(['micelines', 'miCelines', 'MiCelines']);
        $destacados = $this->firstInput(['destacados', 'Destacados']);
        $comentarios = $this->firstInput(['comentarios', 'Comentarios']);

        if (is_string($micelines)) {
            $decoded = json_decode($micelines, true);
            if (is_array($decoded)) {
                $micelines = $decoded;
            }
        }

        if (is_string($destacados)) {
            $decoded = json_decode($destacados, true);
            if (is_array($decoded)) {
                $destacados = $decoded;
            }
        }

        if (is_string($comentarios)) {
            $decoded = json_decode($comentarios, true);
            if (is_array($decoded)) {
                $comentarios = $decoded;
            }
        }

        $data = [];

        if ($heroFrase !== null) {
            $data['hero_frase'] = $heroFrase;
        }
        if ($micelines !== null) {
            $data['micelines'] = $micelines;
        }
        if ($destacados !== null) {
            $data['destacados'] = $destacados;
        }
        if ($comentarios !== null) {
            $data['comentarios'] = $comentarios;
        }

        if ($data !== []) {
            $this->merge($data);
        }
    }

    public function rules(): array
    {
        return [
            'hero_frase' => ['sometimes', 'string', 'max:5000'],
            'hero_imagen' => ['sometimes', 'file', 'image', 'mimes:jpg,jpeg,png,webp', 'max:5120'],
            'micelines' => ['sometimes', 'array'],
            'destacados' => ['sometimes', 'array'],
            'comentarios' => ['sometimes', 'array'],
            'banner' => ['sometimes', 'array', 'max:20'],
            'banner.*' => ['nullable', 'file', 'image', 'mimes:jpg,jpeg,png,webp', 'max:5120'],
        ];
    }

    public function withValidator($validator): void
    {
        $validator->after(function ($validator): void {
            $hasFields = $this->hasAny([
                'hero_frase',
                'micelines',
                'destacados',
                'comentarios',
            ]) || $this->hasFile('hero_imagen') || $this->hasFile('banner');

            if (! $hasFields) {
                $validator->errors()->add('payload', 'Debe enviar al menos un campo para configurar.');
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
