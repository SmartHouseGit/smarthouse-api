<?php

namespace App\Support;

use Illuminate\Support\Facades\URL;

class PrivateMediaUrl
{
    public static function make(?string $path): ?string
    {
        if (! is_string($path) || trim($path) === '') {
            return null;
        }

        if (preg_match('/^https?:\/\//i', $path) === 1) {
            return $path;
        }

        $ttlMinutes = max((int) config('app.media_url_ttl', 30), 1);

        return URL::temporarySignedRoute(
            'media.private',
            now()->addMinutes($ttlMinutes),
            ['path' => ltrim($path, '/')]
        );
    }

    /**
     * @param  array<int, mixed>  $paths
     * @return array<int, string>
     */
    public static function mapMany(array $paths): array
    {
        $urls = [];

        foreach ($paths as $path) {
            if (! is_string($path)) {
                continue;
            }

            $url = self::make($path);
            if ($url !== null) {
                $urls[] = $url;
            }
        }

        return $urls;
    }
}
