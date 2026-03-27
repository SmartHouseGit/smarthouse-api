<?php

namespace App\Support;

use App\Models\Ciudad;
use Illuminate\Support\Str;

class CityRegistryService
{
    public function ensureExists(?string $cityName): void
    {
        if ($cityName === null) {
            return;
        }

        $cityName = trim((string) $cityName);
        if ($cityName === '') {
            return;
        }

        $needle = $this->normalizeForCompare($cityName);

        $exists = Ciudad::query()
            ->get(['nombre'])
            ->contains(fn (Ciudad $ciudad): bool => $this->normalizeForCompare((string) $ciudad->getAttribute('nombre')) === $needle);

        if (! $exists) {
            Ciudad::query()->create([
                'nombre' => $cityName,
            ]);
        }
    }

    private function normalizeForCompare(string $value): string
    {
        $value = Str::ascii($value);
        $value = mb_strtolower($value, 'UTF-8');

        return (string) preg_replace('/\s+/', ' ', trim($value));
    }
}
