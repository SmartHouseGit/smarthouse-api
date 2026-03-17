<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreAdminRequest;
use App\Http\Requests\UpdateAdminRequest;
use App\Models\Admin;
use App\Models\User;
use App\Support\PrivateMediaUrl;
use Illuminate\Database\QueryException;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use Throwable;

class AdminController extends Controller
{
    public function index(Request $request): JsonResponse
    {
        $query = Admin::query();

        $idAdmin = $this->queryValue($request, ['id_admin']);
        $nombre = $this->queryValue($request, ['nombre', 'Nombre']);
        $apellido = $this->queryValue($request, ['apellido', 'Apellido']);
        $telefono = $this->queryValue($request, ['telefono', 'Telefono']);
        $cantidad = $this->queryValue($request, ['cantidad', 'Cantidad']);

        if ($idAdmin !== null) {
            $query->where('id_admin', $idAdmin);
        }
        if ($nombre !== null) {
            $query->where('nombre', 'like', '%'.$nombre.'%');
        }
        if ($apellido !== null) {
            $query->where('apellido', 'like', '%'.$apellido.'%');
        }
        if ($telefono !== null) {
            $query->where('telefono', 'like', '%'.$telefono.'%');
        }
        if ($cantidad !== null && is_numeric($cantidad) && (int) $cantidad > 0) {
            $query->limit((int) $cantidad);
        }

        $admins = $query->get()->map(static function (Admin $admin): array {
            return [
                'id_admin' => $admin->getAttribute('id_admin'),
                'Foto_Portada' => PrivateMediaUrl::make($admin->getAttribute('foto_portada')),
                'Foto_Perfil' => PrivateMediaUrl::make($admin->getAttribute('foto_perfil')),
                'Nombre' => $admin->getAttribute('nombre'),
                'Apellido' => $admin->getAttribute('apellido'),
                'Telefono' => $admin->getAttribute('telefono'),
                'Descripcion_Breve' => $admin->getAttribute('descripcion_breve'),
            ];
        })->values();

        return response()->json([
            'Admins' => $admins,
        ]);
    }

    public function store(StoreAdminRequest $request): JsonResponse
    {
        $creator = $request->user();
        if (! $creator) {
            return response()->json([
                'status' => 'ERROR',
            ], 401);
        }

        $data = $request->validated();
        $storedFiles = [];

        try {
            DB::beginTransaction();

            $fullName = trim($data['nombre'].' '.$data['apellido']);
            if ($fullName === '') {
                $fullName = $data['usuario'];
            }

            $user = User::query()->create([
                'name' => $fullName,
                'email' => $data['usuario'],
                'password' => $data['password'],
                'rol' => (int) env('ROLE_ADMIN_ID', 2),
            ]);

            $fotoPortada = null;
            if ($request->hasFile('foto_portada')) {
                $fotoPortada = $request->file('foto_portada')->store('admins', 'local');
                $storedFiles[] = $fotoPortada;
            }

            $fotoPerfil = null;
            if ($request->hasFile('foto_perfil')) {
                $fotoPerfil = $request->file('foto_perfil')->store('admins', 'local');
                $storedFiles[] = $fotoPerfil;
            }

            Admin::query()->create([
                'userLink' => $user->id,
                'parther' => (int) $creator->id,
                'foto_portada' => $fotoPortada,
                'foto_perfil' => $fotoPerfil,
                'nombre' => $data['nombre'],
                'apellido' => $data['apellido'],
                'telefono' => $data['telefono'],
                'descripcion_breve' => $data['descripcion_breve'],
            ]);

            DB::commit();

            return response()->json([
                'status' => 'OK',
            ]);
        } catch (Throwable $exception) {
            DB::rollBack();

            foreach ($storedFiles as $path) {
                if (is_string($path) && $path !== '') {
                    Storage::disk('local')->delete($path);
                }
            }

            if ($exception instanceof QueryException && (string) $exception->getCode() === '23000') {
                return response()->json([
                    'status' => 'ERROR',
                ], 409);
            }

            return response()->json([
                'status' => 'ERROR',
            ], 500);
        }
    }

    public function update(UpdateAdminRequest $request, int $id_admin): JsonResponse
    {
        $admin = Admin::query()->where('id_admin', $id_admin)->first();

        if (! $admin) {
            return response()->json([
                'status' => 'ERROR',
            ], 404);
        }

        $payload = $request->validated();
        unset($payload['foto_portada'], $payload['foto_perfil']);

        if ($request->hasFile('foto_portada')) {
            $payload['foto_portada'] = $request->file('foto_portada')->store('admins', 'local');
        }

        if ($request->hasFile('foto_perfil')) {
            $payload['foto_perfil'] = $request->file('foto_perfil')->store('admins', 'local');
        }

        try {
            $admin->fill($payload);
            $admin->save();

            return response()->json([
                'status' => 'OK',
            ]);
        } catch (Throwable $exception) {
            return response()->json([
                'status' => 'ERROR',
            ], 500);
        }
    }

    private function queryValue(Request $request, array $keys): mixed
    {
        foreach ($keys as $key) {
            $value = $request->query($key);
            if ($value !== null && $value !== '') {
                return $value;
            }
        }

        return null;
    }
}
