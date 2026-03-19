<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\SetConfigRequest;
use App\Models\AppConfig;
use App\Support\PrivateMediaUrl;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use Throwable;

class ConfigController extends Controller
{
    public function set(SetConfigRequest $request): JsonResponse
    {
        $authUser = $request->user();
        if (! $authUser) {
            return response()->json([
                'status' => 'ERROR',
            ], 401);
        }

        $payload = $request->validated();

        $config = AppConfig::query()->first();
        $isNew = ! $config;
        if (! $config) {
            $config = new AppConfig();
        }

        $replaceHeroImage = $request->hasFile('hero_imagen');
        $replaceBanner = $request->hasFile('banner');

        $oldHeroImage = is_string($config->getAttribute('hero_imagen'))
            ? $config->getAttribute('hero_imagen')
            : null;

        $oldBanner = $config->getAttribute('banner');
        if (! is_array($oldBanner)) {
            $oldBanner = [];
        }

        $newHeroImage = null;
        $newBanner = [];

        try {
            DB::beginTransaction();

            if ($replaceHeroImage) {
                $heroFile = $request->file('hero_imagen');
                if ($heroFile instanceof UploadedFile) {
                    $newHeroImage = $heroFile->store('config', 'local');
                    $payload['hero_imagen'] = $newHeroImage;
                }
            }

            if ($replaceBanner) {
                $bannerFiles = $request->file('banner');
                if (! is_array($bannerFiles)) {
                    $bannerFiles = [$bannerFiles];
                }

                foreach ($bannerFiles as $file) {
                    if ($file instanceof UploadedFile) {
                        $newBanner[] = $file->store('config', 'local');
                    }
                }

                $payload['banner'] = $newBanner;
            }

            $updateData = [];
            if (array_key_exists('hero_frase', $payload)) {
                $updateData['hero_frase'] = $payload['hero_frase'];
            }
            if (array_key_exists('hero_imagen', $payload)) {
                $updateData['hero_imagen'] = $payload['hero_imagen'];
            }
            if (array_key_exists('micelines', $payload)) {
                $updateData['micelines'] = $payload['micelines'];
            }
            if (array_key_exists('destacados', $payload)) {
                $updateData['destacados'] = $payload['destacados'];
            }
            if (array_key_exists('banner', $payload)) {
                $updateData['banner'] = $payload['banner'];
            }
            if (array_key_exists('comentarios', $payload)) {
                $updateData['comentarios'] = $payload['comentarios'];
            }

            if ($isNew) {
                $defaults = [
                    'hero_frase' => null,
                    'hero_imagen' => null,
                    'micelines' => null,
                    'destacados' => null,
                    'banner' => null,
                    'comentarios' => null,
                ];

                $config->fill(array_merge($defaults, $updateData));
            } else {
                $config->fill($updateData);
            }

            $config->save();

            DB::commit();

            if ($replaceHeroImage && is_string($oldHeroImage) && $oldHeroImage !== '' && ! preg_match('/^https?:\/\//i', $oldHeroImage)) {
                Storage::disk('local')->delete($oldHeroImage);
            }

            if ($replaceBanner) {
                foreach ($oldBanner as $path) {
                    if (is_string($path) && $path !== '' && ! preg_match('/^https?:\/\//i', $path)) {
                        Storage::disk('local')->delete($path);
                    }
                }
            }

            return response()->json([
                'status' => 'OK',
            ]);
        } catch (Throwable $exception) {
            DB::rollBack();

            if (is_string($newHeroImage) && $newHeroImage !== '') {
                Storage::disk('local')->delete($newHeroImage);
            }

            foreach ($newBanner as $path) {
                if (is_string($path) && $path !== '') {
                    Storage::disk('local')->delete($path);
                }
            }

            return response()->json([
                'status' => 'ERROR',
            ], 500);
        }
    }

    public function show(): JsonResponse
    {
        $config = AppConfig::query()->first();

        if (! $config) {
            return response()->json([
                'Config' => [
                    'Hero' => [
                        'Frase' => null,
                        'Imagen' => null,
                    ],
                    'MiCelines' => [],
                    'Destacados' => [],
                    'Banner' => [],
                    'Comentarios' => [],
                ],
            ]);
        }

        $banner = $config->getAttribute('banner');
        if (! is_array($banner)) {
            $banner = [];
        }

        return response()->json([
            'Config' => [
                'Hero' => [
                    'Frase' => $config->getAttribute('hero_frase'),
                    'Imagen' => PrivateMediaUrl::make($config->getAttribute('hero_imagen')),
                ],
                'MiCelines' => $config->getAttribute('micelines') ?? [],
                'Destacados' => $config->getAttribute('destacados') ?? [],
                'Banner' => PrivateMediaUrl::mapMany($banner),
                'Comentarios' => $config->getAttribute('comentarios') ?? [],
            ],
        ]);
    }
}
