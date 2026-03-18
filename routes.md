# API Routes

Base URL local:

```
http://127.0.0.1:8000
```

## POST /login

Inicia sesion y devuelve un token Bearer para consumir rutas protegidas.

Campos:

- `usuario` (puede ser email o username)
- `password`
- `device_name` (opcional, por defecto `frontend`)

### Ejemplo request

```bash
curl -X POST "http://127.0.0.1:8000/login" \
  -H "Content-Type: application/json" \
  -d '{
    "usuario": "owner@smarthouse.local",
    "password": "Admin123*",
    "device_name": "frontend"
  }'
```

### Ejemplo response OK

```json
{
  "status": "OK",
  "token": "1|...",
  "token_type": "Bearer",
  "user": {
    "id": 1,
    "name": "Owner",
    "email": "owner@smarthouse.local",
    "rol": "1"
  }
}
```

### Ejemplo response ERROR

```json
{
  "status": "ERROR"
}
```

## GET /testimonios

Obtiene testimonios.  
Parámetro opcional: `cantidad` (número de registros a devolver).

### Ejemplo request

```bash
curl -X GET "http://127.0.0.1:8000/testimonios?cantidad=2"
```

### Ejemplo response

```json
{
  "Testimonios": [
    {
      "id_testimonio": 15012,
      "Nombre": "Valentina Rojas",
      "Localizacion": "Maracay",
      "Testimonio": "En menos de dos meses consolidamos dos operaciones en Caracas y Valencia."
    },
    {
      "id_testimonio": 12859,
      "Nombre": "Pedro Rojas",
      "Localizacion": "Valencia",
      "Testimonio": "Con su acompañamiento logramos cerrar una compra compleja."
    }
  ]
}
```

## POST /contacto

Campos:

- `tipo` (1 o 2)
- `nombre`
- `email`
- `objetivo`
- `mensaje`

### Ejemplo request

```bash
curl -X POST "http://127.0.0.1:8000/contacto" \
  -H "Content-Type: application/json" \
  -d '{
    "tipo": 1,
    "nombre": "Juan Perez",
    "email": "juan@email.com",
    "objetivo": "Comprar inmueble",
    "mensaje": "Quiero asesoria para compra en Caracas."
  }'
```

### Ejemplo response OK

```json
{
  "status": "OK"
}
```

### Ejemplo response ERROR

```json
{
  "status": "ERROR"
}
```

## POST /publicarIn

Campos:

- `nombre`
- `telefono`
- `ciudad`
- `zona`
- `tipo_inmueble`
- `imagen_referencial` (archivo requerido)
- `mensaje`

### Ejemplo request multipart (archivo)

```bash
curl -X POST "http://127.0.0.1:8000/publicarIn" \
  -F "nombre=Maria Gomez" \
  -F "telefono=+584121234567" \
  -F "ciudad=Valencia" \
  -F "zona=Prebo" \
  -F "tipo_inmueble=Apartamento" \
  -F "imagen_referencial=@/ruta/local/foto.jpg" \
  -F "mensaje=Deseo publicar este inmueble."
```

### Ejemplo response

```json
{
  "status": "OK"
}
```

## POST /SolicitarIn

Campos:

- `nombre`
- `telefono`
- `ciudad`
- `zona`
- `tipo_inmueble`
- `presupuesto`
- `mensaje`
- `datos_especificos` (objeto JSON, opcional)
  - `numero_dormitorios`
  - `cantidad_banos`
  - `area_minima_m2`
  - `estacionamientos_minimos`
  - `con_piscina`
  - `pet_friendly`

### Ejemplo request

```bash
curl -X POST "http://127.0.0.1:8000/SolicitarIn" \
  -H "Content-Type: application/json" \
  -d '{
    "nombre": "Carlos Rojas",
    "telefono": "+584148889999",
    "ciudad": "Caracas",
    "zona": "Chacao",
    "tipo_inmueble": "Apartamento",
    "presupuesto": 95000,
    "mensaje": "Busco opcion para compra inmediata.",
    "datos_especificos": {
      "numero_dormitorios": 3,
      "cantidad_banos": 2,
      "area_minima_m2": 90,
      "estacionamientos_minimos": 1,
      "con_piscina": true,
      "pet_friendly": true
    }
  }'
```

### Ejemplo response

```json
{
  "status": "OK"
}
```

## GET /listSol

Lista solicitudes de `contactos`, `solicitar_ins` y/o `publicar_ins` segun el parametro `tipo`.

Autenticacion requerida:

- Bearer token (`Authorization: Bearer <token>`)

Query params:

- `tipo` (requerido): `cont`, `SolIn`, `PubIn` o `all`
- `filter` (opcional): `true` o `false` (por defecto `false`)

Comportamiento de `tipo`:

- `cont`: retorna registros de `contactos`
- `SolIn`: retorna registros de `solicitar_ins`
- `PubIn`: retorna registros de `publicar_ins`
- `all`: retorna registros combinados de las 3 tablas

Comportamiento de `filter=true`:

- Solo considera registros con `ref` no vacio
- Luego filtra por `ref = id` del usuario autenticado por token

Notas:

- Cada registro retorna su `id`
- Cada registro retorna `origen` (`cont`, `SolIn`, `PubIn`) para identificar la tabla de origen

### Ejemplo request

```bash
curl -X GET "http://127.0.0.1:8000/listSol?tipo=all&filter=true" \
  -H "Authorization: Bearer TU_TOKEN"
```

### Ejemplo response

```json
{
  "status": "OK",
  "tipo": "all",
  "Registros": [
    {
      "id": 12,
      "origen": "cont",
      "nombre": "Juan Perez",
      "ref": 5
    },
    {
      "id": 9,
      "origen": "SolIn",
      "nombre": "Maria Rojas",
      "ref": 5
    }
  ]
}
```

## POST /delegarCon

Asigna el campo `ref` de un registro al `id` de un agente.

Autenticacion requerida:

- Bearer token (`Authorization: Bearer <token>`)

Campos:

- `tipo` (requerido): `cont`, `SolIn` o `PubIn`
- `id_registro` (requerido): id del registro a actualizar
- `id_agente` (requerido): id del agente que se guardara en `ref`

### Ejemplo request

```bash
curl -X POST "http://127.0.0.1:8000/delegarCon" \
  -H "Authorization: Bearer TU_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "tipo": "SolIn",
    "id_registro": 9,
    "id_agente": 5
  }'
```

### Ejemplo response

```json
{
  "status": "OK"
}
```

## GET /ciudades

Sin parámetros.

### Ejemplo request

```bash
curl -X GET "http://127.0.0.1:8000/ciudades"
```

### Ejemplo response

```json
{
  "Ciudades": [
    {
      "id_ciudad": 1,
      "Nombre": "Maracay"
    },
    {
      "id_ciudad": 2,
      "Nombre": "Valencia"
    },
    {
      "id_ciudad": 3,
      "Nombre": "Caracas"
    },
    {
      "id_ciudad": 4,
      "Nombre": "Villa de cura"
    }
  ],
  "Testimonios": [
    {
      "id_ciudad": 1,
      "Nombre": "Maracay"
    },
    {
      "id_ciudad": 2,
      "Nombre": "Valencia"
    },
    {
      "id_ciudad": 3,
      "Nombre": "Caracas"
    },
    {
      "id_ciudad": 4,
      "Nombre": "Villa de cura"
    }
  ]
}
```

## POST /setPropiedades

Guarda una propiedad.
Las imágenes deben enviarse como archivos en `multipart/form-data`.

Campos principales:

- `id_publico`
- `nombre`
- `tagline`
- `ciudad_estado`
- `tipo_inmueble`
- `precio`
- `estado_interno`
- `estado_publico`
- `detalles`
- `id_agente`
- `propietario` (id de cliente, opcional por ahora)
- `coordenadas` (`latitud`, `longitud`)
- `datos_especificos` (`dormitorios`, `banos`, `area_m2`, `estacionamientos`, `con_piscina`, `pet_friendly`, `ano_construccion`, `amoblada`, `balcon`, `seguridad_privada`, `financiable`)
- `foto_principal`
- `fotos_secundarias` (máximo 8)

### Ejemplo request multipart (archivo)

```bash
curl -X POST "http://127.0.0.1:8000/setPropiedades" \
  -F "id_publico=PUB-0002" \
  -F "nombre=Casa Los Naranjos" \
  -F "tagline=Casa familiar en zona exclusiva" \
  -F "ciudad_estado=Caracas, Distrito Capital" \
  -F "tipo_inmueble=Casa" \
  -F "precio=185000" \
  -F "estado_interno=disponible" \
  -F "estado_publico=publicado" \
  -F "detalles=Casa de dos niveles remodelada." \
  -F "id_agente=2" \
  -F "propietario=202" \
  -F "coordenadas={\"latitud\":10.4806,\"longitud\":-66.9036}" \
  -F "datos_especificos={\"dormitorios\":4,\"banos\":3,\"area_m2\":220,\"estacionamientos\":2,\"con_piscina\":false,\"pet_friendly\":true,\"ano_construccion\":2012,\"amoblada\":false,\"balcon\":true,\"seguridad_privada\":true,\"financiable\":true}" \
  -F "foto_principal=@/ruta/local/principal.jpg" \
  -F "fotos_secundarias[]=@/ruta/local/sec-1.jpg" \
  -F "fotos_secundarias[]=@/ruta/local/sec-2.jpg"
```

### Ejemplo response

```json
{
  "status": "OK"
}
```

## GET /obtPropiedades

Obtiene la lista de propiedades.
Las fotos se devuelven como URLs privadas firmadas y temporales.

Filtros soportados (query params):

- `id_interno`
- `id_publico`
- `nombre`
- `tagline`
- `ciudad_estado`
- `tipo_inmueble`
- `estado_interno`
- `estado_publico`
- `id_agente`
- `propietario`
- `precio_min`
- `precio_max`
- `latitud`
- `longitud`
- `dormitorios`
- `banos`
- `area_m2`
- `estacionamientos`
- `ano_construccion`
- `con_piscina`
- `pet_friendly`
- `amoblada`
- `balcon`
- `seguridad_privada`
- `financiable`
- `cantidad`

### Ejemplo request

```bash
curl -X GET "http://127.0.0.1:8000/obtPropiedades?ciudad_estado=Valencia&tipo_inmueble=Apartamento&id_agente=1&tagline=retorno&precio_min=100000&precio_max=180000&dormitorios=3&con_piscina=true&cantidad=20"
```

### Ejemplo response

```json
{
  "Propiedades": [
    {
      "id_interno": 1,
      "id_publico": "PUB-0001",
      "Nombre": "Residencias El Bosque",
      "Tagline": "Ubicacion premium y excelente retorno",
      "Ciudad_Estado": "Valencia, Carabobo",
      "Tipo_Inmueble": "Apartamento",
      "Precio": 125000,
      "Estado_Interno": "disponible",
      "Estado_Publico": "publicado",
      "Detalles": "Apartamento en excelente zona, cerca de centros comerciales.",
      "Datos_Especificos": {
        "dormitorios": 3,
        "banos": 2,
        "area_m2": 110,
        "estacionamientos": 2,
        "con_piscina": true,
        "pet_friendly": true,
        "ano_construccion": 2018,
        "amoblada": false,
        "balcon": true,
        "seguridad_privada": true,
        "financiable": true
      },
      "id_agente": 1,
      "Agente_Encargado": 1,
      "Propietario": 101,
      "Coordenadas": {
        "latitud": 10.162,
        "longitud": -68.0077
      },
      "Fotos": {
        "principal": "https://k7pr2wn9xm4tb6vl1zq8.info/media/propiedades/p-1-main.jpg?expires=1710531000&signature=abc123",
        "secundarias": [
          "https://k7pr2wn9xm4tb6vl1zq8.info/media/propiedades/p-1-2.jpg?expires=1710531000&signature=def456",
          "https://k7pr2wn9xm4tb6vl1zq8.info/media/propiedades/p-1-3.jpg?expires=1710531000&signature=ghi789"
        ]
      }
    }
  ]
}
```

## GET /media/{path}

Endpoint interno para servir archivos privados.
No se consume directamente; la URL firmada se obtiene desde `GET /obtPropiedades`.

## GET /obtAdmins

Lista admins. Filtros opcionales:
Las fotos se devuelven como URLs privadas firmadas y temporales.

- `id_admin`
- `nombre`
- `apellido`
- `telefono`
- `cantidad`

### Ejemplo request

```bash
curl -X GET "http://127.0.0.1:8000/obtAdmins?apellido=Rojas&cantidad=10"
```

### Ejemplo response

```json
{
  "Admins": [
    {
      "id_admin": 1,
      "Foto_Portada": "https://dominio.com/media/admins/portada-1.jpg?...",
      "Foto_Perfil": "https://dominio.com/media/admins/perfil-1.jpg?...",
      "Nombre": "Laura",
      "Apellido": "Rojas",
      "Telefono": "+584121234567",
      "Descripcion_Breve": "Administradora comercial."
    }
  ]
}
```

## POST /setAdmin

Crea un usuario en `users` y luego un admin en `admins` dentro de una transaccion.
Si falla cualquiera de los dos pasos, se revierte todo.

Autenticacion requerida:

- Bearer token (`Authorization: Bearer <token>`)

Campos requeridos:

- `usuario` (email; se guarda en `users.email`)
- `password`
- `nombre`
- `apellido`
- `telefono`
- `descripcion_breve`

Campos opcionales:

- `foto_portada` (archivo imagen)
- `foto_perfil` (archivo imagen)

Notas:

- `userLink` se llena automaticamente con el id del usuario creado.
- `parther` se llena automaticamente con el id del usuario autenticado (quien crea).
- El usuario se crea con rol de admin (`ROLE_ADMIN_ID`, por defecto `2`).

### Ejemplo request JSON (sin fotos)

```bash
curl -X POST "http://127.0.0.1:8000/setAdmin" \
  -H "Authorization: Bearer TU_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "usuario": "admin1@smarthouse.local",
    "password": "Admin123*",
    "nombre": "Laura",
    "apellido": "Mendoza",
    "telefono": "+584121112233",
    "descripcion_breve": "Administradora comercial."
  }'
```

### Ejemplo response OK

```json
{
  "status": "OK"
}
```

### Ejemplo response ERROR

```json
{
  "status": "ERROR"
}
```

## PATCH /updAdmin/{id_admin}

Actualiza admin de forma parcial o total.

### Ejemplo request

```bash
curl -X PATCH "http://127.0.0.1:8000/updAdmin/1" \
  -H "Content-Type: application/json" \
  -d '{
    "telefono": "+584149998877"
  }'
```

### Ejemplo response

```json
{
  "status": "OK"
}
```

## GET /obtAgentes

Lista agentes. Filtros opcionales:
Las fotos se devuelven como URLs privadas firmadas y temporales.

- `id_agente`
- `nombre`
- `apellido`
- `telefono`
- `cantidad`

### Ejemplo request

```bash
curl -X GET "http://127.0.0.1:8000/obtAgentes?apellido=Rojas&cantidad=10"
```

### Ejemplo response

```json
{
  "Agentes": [
    {
      "id_agente": 1,
      "Foto_Portada": "https://k7pr2wn9xm4tb6vl1zq8.info/media/agentes/portada-1.jpg?expires=1710531000&signature=abc123",
      "Foto_Perfil": "https://k7pr2wn9xm4tb6vl1zq8.info/media/agentes/perfil-1.jpg?expires=1710531000&signature=def456",
      "Nombre": "Valentina",
      "Apellido": "Rojas",
      "Telefono": "+584121234567",
      "Descripcion_Breve": "Asesora comercial con enfoque en inmuebles residenciales."
    }
  ]
}
```

## POST /setAgente

Crea un usuario en `users` y luego un agente en `agentes` dentro de una transaccion.
Si falla cualquiera de los dos pasos, se revierte todo.

Autenticacion requerida:

- Bearer token (`Authorization: Bearer <token>`)

Campos requeridos:

- `usuario` (email; se guarda en `users.email`)
- `password`
- `nombre`
- `apellido`
- `telefono`
- `descripcion_breve`

Campos opcionales:

- `foto_portada` (archivo imagen)
- `foto_perfil` (archivo imagen)

Notas:

- `userLink` se llena automaticamente con el id del usuario creado.
- `parther` se llena automaticamente con el id del usuario autenticado (quien crea).
- El usuario se crea con rol de agente (`ROLE_AGENT_ID`, por defecto `3`).

### Ejemplo request JSON (sin fotos)

```bash
curl -X POST "http://127.0.0.1:8000/setAgente" \
  -H "Authorization: Bearer TU_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "usuario": "agente1@smarthouse.local",
    "password": "Agente123*",
    "nombre": "Valentina",
    "apellido": "Rojas",
    "telefono": "+584121234567",
    "descripcion_breve": "Asesora comercial con enfoque en inmuebles residenciales."
  }'
```

### Ejemplo request multipart (con fotos)

```bash
curl -X POST "http://127.0.0.1:8000/setAgente" \
  -H "Authorization: Bearer TU_TOKEN" \
  -F "usuario=agente2@smarthouse.local" \
  -F "password=Agente123*" \
  -F "nombre=Valentina" \
  -F "apellido=Rojas" \
  -F "telefono=+584121234567" \
  -F "descripcion_breve=Asesora comercial con enfoque en inmuebles residenciales." \
  -F "foto_portada=@/ruta/local/portada.jpg" \
  -F "foto_perfil=@/ruta/local/perfil.jpg"
```

### Ejemplo response OK

```json
{
  "status": "OK"
}
```

### Ejemplo response ERROR (duplicado/conflicto)

```json
{
  "status": "ERROR"
}
```

## PATCH /updAgente/{id_agente}

Actualiza agente de forma parcial o total.

### Ejemplo request (solo apellido)

```bash
curl -X PATCH "http://127.0.0.1:8000/updAgente/1" \
  -H "Content-Type: application/json" \
  -d '{
    "apellido": "Mendoza"
  }'
```

### Ejemplo request (solo portada con archivo)

```bash
curl -X PATCH "http://127.0.0.1:8000/updAgente/1" \
  -F "foto_portada=@/ruta/local/nueva-portada.jpg"
```

### Ejemplo response

```json
{
  "status": "OK"
}
```

## GET /obtClientes

Lista clientes. Las fotos se devuelven como URLs privadas firmadas y temporales.

Autenticacion requerida:

- Bearer token (`Authorization: Bearer <token>`)

Reglas por rol:

- Owner (`rol = 1`): retorna todos los clientes.
- Admin (`rol = 2`): busca agentes con `parther = id` del usuario admin autenticado y retorna clientes cuyo `agente_res` pertenezca a esos agentes.
- Agente (`rol = 3`): retorna solo clientes con `agente_res = id` del usuario autenticado.

Filtros opcionales (se aplican dentro del alcance del rol):

- `id_cliente`
- `nombre`
- `tipo`
- `estado`
- `telefono`
- `correo`
- `ciudad`
- `documento_rif`
- `agente_res`
- `cantidad`

### Ejemplo request

```bash
curl -X GET "http://127.0.0.1:8000/obtClientes?ciudad=Valencia&tipo=Comprador&cantidad=20" \
  -H "Authorization: Bearer TU_TOKEN"
```

### Ejemplo response

```json
{
  "Clientes": [
    {
      "id_cliente": 1,
      "Foto": "https://k7pr2wn9xm4tb6vl1zq8.info/media/clientes/foto-1.jpg?expires=1710531000&signature=abc123",
      "Portada": "https://k7pr2wn9xm4tb6vl1zq8.info/media/clientes/portada-1.jpg?expires=1710531000&signature=def456",
      "Nombre": "Carlos Rojas",
      "Perfil": "Cliente interesado en compra de apartamento familiar.",
      "Tipo": "Comprador",
      "Estado": "Activo",
      "Telefono": "+584141112233",
      "Correo": "carlos@email.com",
      "Direccion": "Av. Principal, Valencia",
      "Ciudad": "Valencia",
      "Documento_RIF": "V-12345678",
      "Notas": "Prefiere zona norte.",
      "agente_res": 1
    }
  ]
}
```

## POST /setCliente

Crea un cliente nuevo.
Las imágenes deben enviarse como archivos en `multipart/form-data`.

Autenticacion requerida:

- Bearer token (`Authorization: Bearer <token>`)

Campos:

- `foto`
- `portada`
- `nombre`
- `perfil`
- `tipo`
- `estado`
- `telefono`
- `correo`
- `direccion`
- `ciudad`
- `documento_rif`
- `notas` (opcional)

Notas:

- `agente_res` no se envía en el request.
- `agente_res` se llena automaticamente con el `id` del usuario autenticado por el Bearer token.

### Ejemplo request multipart (archivo)

```bash
curl -X POST "http://127.0.0.1:8000/setCliente" \
  -H "Authorization: Bearer TU_TOKEN" \
  -F "foto=@/ruta/local/foto.jpg" \
  -F "portada=@/ruta/local/portada.jpg" \
  -F "nombre=Carlos Rojas" \
  -F "perfil=Cliente interesado en compra de apartamento familiar." \
  -F "tipo=Comprador" \
  -F "estado=Activo" \
  -F "telefono=+584141112233" \
  -F "correo=carlos@email.com" \
  -F "direccion=Av. Principal, Valencia" \
  -F "ciudad=Valencia" \
  -F "documento_rif=V-12345678" \
  -F "notas=Prefiere zona norte."
```

### Ejemplo response

```json
{
  "status": "OK"
}
```

## PATCH /updCliente/{id_cliente}

Actualiza cliente de forma parcial o total.

### Ejemplo request (solo telefono)

```bash
curl -X PATCH "http://127.0.0.1:8000/updCliente/1" \
  -H "Content-Type: application/json" \
  -d '{
    "telefono": "+584149998877"
  }'
```

### Ejemplo request (solo portada con archivo)

```bash
curl -X PATCH "http://127.0.0.1:8000/updCliente/1" \
  -F "portada=@/ruta/local/nueva-portada.jpg"
```

### Ejemplo response

```json
{
  "status": "OK"
}
```
