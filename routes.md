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

## PATCH /changePassword

Cambia la contraseña del usuario autenticado.

Autenticacion y permisos:

- Requiere Bearer token (`Authorization: Bearer <token>`)
- Solo usuarios con `rol = 8`

Campos:

- `currentPassword` (requerido)
- `newPassword` (requerido, min 8)
- `newPasswordConfirmation` (requerido, debe coincidir)

### Ejemplo request

```bash
curl -X PATCH "http://127.0.0.1:8000/changePassword" \
  -H "Authorization: Bearer TU_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "currentPassword": "ClaveActual123",
    "newPassword": "NuevaClave456",
    "newPasswordConfirmation": "NuevaClave456"
  }'
```

### Ejemplo response OK

```json
{
  "status": "OK"
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


## PATCH /updSol

Actualiza el campo `estado` de una solicitud en `contactos`, `solicitar_ins` o `publicar_ins`.

Autenticacion requerida:

- Bearer token (`Authorization: Bearer <token>`)

Campos:

- `tipo` (requerido): `cont`, `SolIn` o `PubIn`
- `id_registro` (requerido): id del registro a actualizar
- `estado` (requerido como campo; puede ser texto o `null`)

### Ejemplo request

```bash
curl -X PATCH "http://127.0.0.1:8000/updSol" \
  -H "Authorization: Bearer TU_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "tipo": "SolIn",
    "id_registro": 9,
    "estado": "En seguimiento"
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
- `etiqueta`
- `ciudad_estado`
- `zona`
- `tipo_inmueble`
- `precio`
- `estado_interno`
- `estado_publico`
- `detalles`
- `id_agente`
- `propietario` (id de cliente, opcional por ahora)
- `tipo_af` (opcional: `Interna` o `Externa`)
- `af_content` (opcional: lista separada por comas)
  - Si `tipo_af=Interna`: enviar correos de agentes. Se guarda como `Nombre Apellido-ID`.
  - Si `tipo_af=Externa`: enviar nombres. Se guarda tal cual (sin ids).
- `coordenadas` (`latitud`, `longitud`)
- `datos_especificos` (`dormitorios`, `banos`, `area_m2`, `estacionamientos`, `con_piscina`, `pet_friendly`, `ano_construccion`, `amoblada`, `balcon`, `seguridad_privada`, `financiable`)
- `foto_principal`
- `fotos_secundarias` (máximo 12)

### Ejemplo request multipart (archivo)

```bash
curl -X POST "http://127.0.0.1:8000/setPropiedades" \
  -F "id_publico=PUB-0002" \
  -F "nombre=Casa Los Naranjos" \
  -F "etiqueta=Casa familiar en zona exclusiva" \
  -F "ciudad_estado=Caracas, Distrito Capital" \
  -F "zona=Los Naranjos" \
  -F "tipo_inmueble=Casa" \
  -F "precio=185000" \
  -F "estado_interno=disponible" \
  -F "estado_publico=publicado" \
  -F "detalles=Casa de dos niveles remodelada." \
  -F "id_agente=2" \
  -F "propietario=202" \
  -F "tipo_af=Interna" \
  -F "af_content=agente1@dominio.com,agente2@dominio.com" \
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

## PATCH /updPropiedad/{id_interno}

Actualiza una propiedad existente de forma parcial.

Autenticacion requerida:

- Bearer token (`Authorization: Bearer <token>`)

Todos los campos son opcionales (se actualizan solo los enviados):

- `id_publico`
- `nombre`
- `etiqueta`
- `ciudad_estado`
- `zona`
- `tipo_inmueble`
- `precio`
- `estado_interno`
- `estado_publico`
- `detalles`
- `id_agente`
- `propietario`
- `tipo_af` (`Interna` o `Externa`)
- `af_content` (lista separada por comas)
- `coordenadas` (`latitud`, `longitud`)
- `datos_especificos`
- `foto_principal` (archivo)
- `fotos_secundarias` (archivos, maximo 12)

Reglas de afiliacion:

- Si `tipo_af=Interna`, `af_content` debe contener correos validos de agentes.
- Si `tipo_af=Externa`, `af_content` se guarda como nombres en texto.

### Ejemplo request multipart

```bash
curl -X PATCH "http://127.0.0.1:8000/updPropiedad/12" \
  -H "Authorization: Bearer TU_TOKEN" \
  -F "nombre=Casa Los Naranjos (actualizada)" \
  -F "etiqueta=Oportunidad de inversion" \
  -F "precio=195000" \
  -F "estado_interno=disponible" \
  -F "coordenadas={\"latitud\":10.4806,\"longitud\":-66.9036}" \
  -F "foto_principal=@/ruta/local/nueva-principal.jpg" \
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

Comportamiento con Bearer token:

- Con token valido: cada propiedad incluye `tipo_af` y `af_content`.
  - En `af_content` para `Interna` se devuelven solo nombres (sin ids).
- Sin token (o token invalido): no se devuelven `tipo_af` ni `af_content`.

Filtros soportados (query params):

- `id_interno`
- `id_publico`
- `nombre`
- `etiqueta`
- `ciudad_estado`
- `zona`
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
curl -X GET "http://127.0.0.1:8000/obtPropiedades?ciudad_estado=Valencia&zona=Centro&tipo_inmueble=Apartamento&id_agente=1&etiqueta=retorno&precio_min=100000&precio_max=180000&dormitorios=3&con_piscina=true&cantidad=20"
```

### Ejemplo response

```json
{
  "Propiedades": [
    {
      "id_interno": 1,
      "id_publico": "PUB-0001",
      "Nombre": "Residencias El Bosque",
      "Etiqueta": "Ubicacion premium y excelente retorno",
      "Ciudad_Estado": "Valencia, Carabobo",
      "Zona": "Zona Referencial",
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
      "Agente_Encargado": "Ramona Rojas",
      "Telefono_Agente": "+584121234567",
      "tipo_af": "Interna",
      "af_content": "Ramon Gonzales,Maria Rubieta,Luis Alvarado",
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

Autenticacion requerida:

- Bearer token (`Authorization: Bearer <token>`)

Campos opcionales relevantes:

- `usuario` (email, actualiza `users.email`)
- `password` (actualiza `users.password`)
- `nombre` y/o `apellido` (actualiza `admins` y sincroniza `users.name`)
- `telefono`, `descripcion_breve`, `foto_portada`, `foto_perfil`

### Ejemplo request

```bash
curl -X PATCH "http://127.0.0.1:8000/updAdmin/1" \
  -H "Authorization: Bearer TU_TOKEN" \
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

Lista agentes subordinados al usuario autenticado.
Las fotos se devuelven como URLs privadas firmadas y temporales.

Autenticacion requerida:

- Bearer token (`Authorization: Bearer <token>`)

Regla de acceso:

- Solo retorna agentes donde `parther` sea igual al `id` del usuario del token.

Filtros opcionales:

- `id_agente`
- `nombre`
- `apellido`
- `telefono`
- `cantidad`

Notas:

- Cada agente incluye `Email` tomado de `users.email` usando `agentes.userLink`.

### Ejemplo request

```bash
curl -X GET "http://127.0.0.1:8000/obtAgentes?apellido=Rojas&cantidad=10" \
  -H "Authorization: Bearer TU_TOKEN"
```

### Ejemplo response

```json
{
  "Agentes": [
    {
      "id_agente": 1,
      "Email": "valentina.rojas@smarthouse.local",
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

Autenticacion requerida:

- Bearer token (`Authorization: Bearer <token>`)

Campos opcionales relevantes:

- `usuario` (email, actualiza `users.email`)
- `password` (actualiza `users.password`)
- `nombre` y/o `apellido` (actualiza `agentes` y sincroniza `users.name`)
- `telefono`, `descripcion_breve`, `foto_portada`, `foto_perfil`

### Ejemplo request (solo apellido)

```bash
curl -X PATCH "http://127.0.0.1:8000/updAgente/1" \
  -H "Authorization: Bearer TU_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "apellido": "Mendoza"
  }'
```

### Ejemplo request (solo portada con archivo)

```bash
curl -X PATCH "http://127.0.0.1:8000/updAgente/1" \
  -H "Authorization: Bearer TU_TOKEN" \
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

## GET /obtCierres

Lista cierres segun rol del usuario autenticado.
`Archivos` se devuelve como URLs privadas, firmadas y temporales.

Autenticacion requerida:

- Bearer token (`Authorization: Bearer <token>`)

Reglas por rol:

- Owner (`rol = 1`): retorna todos los cierres.
- Admin (`rol = 2`): busca agentes con `parther = id` del usuario admin autenticado y retorna cierres cuyo `ref` pertenezca a esos agentes.
- Agente (`rol = 3`): retorna cierres cuyo `ref` coincida con su alcance de agente.

Filtros opcionales:

- `id_cierre`
- `fecha`
- `tipo_cierre`
- `estado_cierre`
- `id_cliente`
- `ciudad`
- `ref`
- `cantidad`

### Ejemplo request

```bash
curl -X GET "http://127.0.0.1:8000/obtCierres?ciudad=Valencia&estado_cierre=Inicial&cantidad=20" \
  -H "Authorization: Bearer TU_TOKEN"
```

### Ejemplo response

```json
{
  "Cierres": [
    {
      "id_cierre": 1,
      "ref": 5,
      "Fecha": "2026-03-18",
      "Tipo_Cierre": "Venta",
      "Estado_Cierre": "Inicial",
      "Codigos_Propiedades": ["PUB-0001", "PUB-0002"],
      "Titulo": "Cierre residencial marzo",
      "Precio_Base": "125000.00",
      "Monto_Cerrado": "119500.00",
      "id_cliente": 1,
      "Ciudad": "Valencia",
      "Archivos": [
        "https://k7pr2wn9xm4tb6vl1zq8.info/media/cierres/contrato.pdf?expires=1710531000&signature=abc123",
        "https://k7pr2wn9xm4tb6vl1zq8.info/media/cierres/comprobante.jpg?expires=1710531000&signature=def456"
      ],
      "Nota": "Cliente aprobado para firma"
    }
  ]
}
```

## POST /setCierre

Crea un cierre y guarda `ref` con el `id_agente` asociado al token.
Permite adjuntar cero, uno o varios archivos.

Autenticacion requerida:

- Bearer token (`Authorization: Bearer <token>`)

Campos requeridos:

- `fecha` (date)
- `tipo_cierre` (`Venta`, `Alquiler`, `Remodelacion`, `asesoria`, `negocio`)
- `estado_cierre` (`Inicial`, `terminado`)
- `titulo`
- `precio_base`
- `monto_cerrado`
- `ciudad`

Campos opcionales:

- `codigos_propiedades` (JSON array de codigos)
- `id_cliente`
- `nota`
- `archivos[]` (max 10 archivos)

Notas:

- El backend identifica el agente por token (`agentes.userLink = users.id`).
- Se guarda `ref` con `agentes.id_agente`.
- Archivos se guardan en almacenamiento local bajo `cierres/`.
- Si envias `codigos_propiedades`, esas propiedades pasan a `estado_interno = En negociacion` al crear el cierre.

### Ejemplo request multipart

```bash
curl -X POST "http://127.0.0.1:8000/setCierre" \
  -H "Authorization: Bearer TU_TOKEN" \
  -F "fecha=2026-03-18" \
  -F "tipo_cierre=Venta" \
  -F "estado_cierre=Inicial" \
  -F "codigos_propiedades=[\"PUB-0001\",\"PUB-0002\"]" \
  -F "titulo=Cierre residencial marzo" \
  -F "precio_base=125000" \
  -F "monto_cerrado=119500" \
  -F "id_cliente=1" \
  -F "ciudad=Valencia" \
  -F "nota=Cliente aprobado para firma" \
  -F "archivos[]=@/ruta/local/contrato.pdf" \
  -F "archivos[]=@/ruta/local/comprobante.jpg"
```

### Ejemplo response

```json
{
  "status": "OK"
}
```

## PATCH /updCierre

Actualiza un cierre de forma parcial usando `id_cierre` enviado en el body.

Autenticacion requerida:

- Bearer token (`Authorization: Bearer <token>`)

Campos:

- `id_cierre` (requerido)
- `fecha` (opcional)
- `tipo_cierre` (opcional)
- `estado_cierre` (opcional)
- `codigos_propiedades` (opcional, JSON array)
- `titulo` (opcional)
- `precio_base` (opcional)
- `monto_cerrado` (opcional)
- `id_cliente` (opcional)
- `ciudad` (opcional)
- `nota` (opcional)
- `ref` (opcional)
- `archivos[]` (opcional, reemplaza los archivos actuales si se envia)

Notas:

- Debes enviar al menos un campo adicional a `id_cierre`.
- Si envias `archivos[]`, el cierre reemplaza la lista actual de archivos por los nuevos.
- Se mantiene el control por token/rol: owner puede actualizar todos; admin y agente solo cierres dentro de su alcance.
- Si `estado_cierre` cambia de `Inicial` a `terminado`, las propiedades asociadas quedan con `estado_interno = Cerrada`.

### Ejemplo request multipart

```bash
curl -X PATCH "http://127.0.0.1:8000/updCierre" \
  -H "Authorization: Bearer TU_TOKEN" \
  -F "id_cierre=12" \
  -F "estado_cierre=terminado" \
  -F "nota=Cierre finalizado y firmado" \
  -F "archivos[]=@/ruta/local/acta.pdf"
```

### Ejemplo response

```json
{
  "status": "OK"
}
```

## POST /setDivisionCierre

Crea la division de comision para un cierre y propiedad.

Autenticacion requerida:

- Bearer token (`Authorization: Bearer <token>`)

Campos requeridos:

- `id_cierre`
- `id_propiedad`
- `tipo_afiliacion` (`ninguna`, `interna`, `externa`)
- `participantes` (objeto JSON: clave `nombre_o_correo`, valor `Captador` o `Vendedor`)

Reglas:

- Solo permite un registro por combinacion `id_cierre + id_propiedad`.
- Si en `participantes` viene correo, se resuelve agente por `users.email -> agentes.userLink`.
- Si correo no corresponde a un agente: `422` con mensaje `El agente no existe.`
- Debe existir al menos un `Captador` y un `Vendedor`; si no, retorna `422`.

Calculo:

- Si `monto_cerrado <= 20000`: `comision_total = 1000`.
- Si `monto_cerrado > 20000`: `comision_total = monto_cerrado * 0.05`.
- `comision_inmobiliaria = 40%` de `comision_total`.
- `bolsa_participantes = 60%` de `comision_total`.
- `pool_captadores = 50%` de `bolsa_participantes`.
- `pool_vendedores = 50%` de `bolsa_participantes`.
- Cada pool se reparte equitativamente por cantidad de participantes de su tipo.

### Ejemplo request

```bash
curl -X POST "http://127.0.0.1:8000/setDivisionCierre" \
  -H "Authorization: Bearer TU_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "id_cierre": 12,
    "id_propiedad": 5,
    "tipo_afiliacion": "interna",
    "participantes": {
      "agent4@s.s": "Captador",
      "Maria Eugenia": "Captador",
      "Raul Savientos": "Vendedor",
      "Pedor acosta": "Vendedor"
    }
  }'
```

### Ejemplo response

```json
{
  "status": "OK"
}
```

## GET /obtDivisionCierres

Lista divisiones de cierres.

Autenticacion requerida:

- Bearer token (`Authorization: Bearer <token>`)

Regla de acceso:

- Solo Owner (`rol = 1`) puede consultar.

Filtros opcionales:

- `id_division`
- `id_cierre`
- `id_propiedad`
- `tipo_afiliacion`
- `cantidad`

### Ejemplo request

```bash
curl -X GET "http://127.0.0.1:8000/obtDivisionCierres?id_cierre=12" \
  -H "Authorization: Bearer TU_TOKEN_OWNER"
```

### Ejemplo response

```json
{
  "Divisiones": [
    {
      "id_division": 3,
      "id_cierre": 12,
      "id_propiedad": 5,
      "tipo_afiliacion": "interna",
      "monto_cerrado": 50000,
      "comision_total": 2500,
      "comision_inmobiliaria": 1000,
      "bolsa_participantes": 1500,
      "pool_captadores": 750,
      "pool_vendedores": 750,
      "participantes": [],
      "distribucion": [],
      "created_by": 1,
      "created_at": "2026-04-17T00:00:00.000000Z",
      "updated_at": "2026-04-17T00:00:00.000000Z"
    }
  ]
}
```

## GET /obtReuniones

Lista reuniones segun rol y parametro `sel`.

Autenticacion requerida:

- Bearer token (`Authorization: Bearer <token>`)

Parametros query:

- `sel` (opcional): `true` o `false`.

Reglas:

- Agente (`rol = 3`): ignora `sel` y retorna reuniones donde `ref = id` del usuario autenticado.
- Admin (`rol = 2`) + `sel = true`:
  - Busca agentes con `parther = id` del admin.
  - Toma `userLink` de esos agentes.
  - Retorna reuniones donde `ref` este en esos `userLink`.
- Admin (`rol = 2`) + `sel = false` (o no enviado): retorna reuniones donde `ref = id` del admin autenticado.

### Ejemplo request (admin, sel=true)

```bash
curl -X GET "http://127.0.0.1:8000/obtReuniones?sel=true" \
  -H "Authorization: Bearer TU_TOKEN"
```

### Ejemplo request (agente, sel ignorado)

```bash
curl -X GET "http://127.0.0.1:8000/obtReuniones?sel=true" \
  -H "Authorization: Bearer TU_TOKEN"
```

### Ejemplo response

```json
{
  "Reuniones": [
    {
      "id_reunion": 10,
      "Titulo": "Revision de cierre",
      "Fecha": "2026-03-20",
      "Hora": "10:30:00",
      "Lugar": "Oficina Valencia",
      "id_cliente": 1,
      "Notas": "Primera reunion de seguimiento",
      "ref": 5,
      "mod": true,
      "Estado": null
    }
  ]
}
```

## POST /setReunion

Crea una reunion.

Autenticacion requerida:

- Bearer token (`Authorization: Bearer <token>`)

Campos requeridos:

- `titulo`
- `fecha`
- `hora` (formato `HH:MM` o `HH:MM:SS`)
- `lugar`
- `mod` (`true` o `false`)

Campos opcionales:

- `id_cliente` (cliente asociado)
- `notas`
- `ref`
- `estado` (se ignora en creacion; inicia en `null`)

Regla de `mod`:

- Si `mod = true`, el backend rellena `ref` automaticamente con el `id` del usuario autenticado por token.
- Si `mod = false`, debes enviar `ref` manualmente.

### Ejemplo request (mod true)

```bash
curl -X POST "http://127.0.0.1:8000/setReunion" \
  -H "Authorization: Bearer TU_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "titulo": "Revision de cierre",
    "fecha": "2026-03-20",
    "hora": "10:30",
    "lugar": "Oficina Valencia",
    "id_cliente": 1,
    "notas": "Primera reunion de seguimiento",
    "mod": true
  }'
```

### Ejemplo request (mod false)

```bash
curl -X POST "http://127.0.0.1:8000/setReunion" \
  -H "Authorization: Bearer TU_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "titulo": "Reunion comercial",
    "fecha": "2026-03-21",
    "hora": "14:00",
    "lugar": "Zoom",
    "ref": 5,
    "mod": false
  }'
```

### Ejemplo response

```json
{
  "status": "OK"
}
```

## PATCH /updReunion

Actualiza reunion de forma parcial usando `id_reunion` enviado en el body.

Autenticacion requerida:

- Bearer token (`Authorization: Bearer <token>`)

Campos:

- `id_reunion` (requerido)
- `titulo` (opcional)
- `fecha` (opcional)
- `hora` (opcional)
- `lugar` (opcional)
- `id_cliente` (opcional)
- `notas` (opcional)
- `ref` (opcional)
- `mod` (opcional)
- `estado` (opcional)

Notas:

- Debes enviar al menos un campo adicional a `id_reunion` para actualizar.
- No hay regla especial de `mod` en update.

### Ejemplo request

```bash
curl -X PATCH "http://127.0.0.1:8000/updReunion" \
  -H "Authorization: Bearer TU_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "id_reunion": 10,
    "notas": "Reprogramada para la tarde",
    "estado": "confirmada"
  }'
```

### Ejemplo response

```json
{
  "status": "OK"
}
```

## POST /setRuta

Crea una ruta operativa.

Autenticacion requerida:

- Bearer token (`Authorization: Bearer <token>`)

Regla de rol:

- Solo Admin (`rol = 2`) puede crear rutas.
- Si el token no es admin: `403`.

Campos requeridos:

- `zona`
- `hora_inicio` (formato `HH:MM` o `HH:MM:SS`)
- `hora_final` (formato `HH:MM` o `HH:MM:SS`)
- `sectores` (JSON array)
- `ubicacion_inicial` (JSON con `lat` y `lng`)
- `recaudos` (JSON array de textos)

Notas:

- `ref` no se envia, se toma del `id` del usuario autenticado por token.
- Al crear se inicializa en `null`: `agentes`, `resultados`, `notas`.

### Ejemplo request

```bash
curl -X POST "http://127.0.0.1:8000/setRuta" \
  -H "Authorization: Bearer TU_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "zona": "Zona Norte",
    "hora_inicio": "08:00",
    "hora_final": "18:00",
    "sectores": ["El Bosque", "La Soledad"],
    "ubicacion_inicial": {
      "lat": 10.251,
      "lng": -67.595
    },
    "recaudos": ["comentarios", "paquetes_entregados", "fotos"]
  }'
```

### Ejemplo response

```json
{
  "status": "OK"
}
```

## PATCH /updRuta

Actualiza una ruta de forma parcial usando `id_ruta` en el body.

Autenticacion requerida:

- Bearer token (`Authorization: Bearer <token>`)

Campos:

- `id_ruta` (requerido)
- `resultados` (opcional, JSON anidado)
- `nota` (opcional)

Reglas por rol:

- Owner (`rol = 1`): puede actualizar cualquier ruta.
- Admin (`rol = 2`): solo rutas donde `ref = id` del admin autenticado.
- Agente (`rol = 3`): solo rutas donde `ref = parther` del agente autenticado.

Notas:

- `resultados` se agrega al arreglo actual (append), no reemplaza los datos existentes.
- Debes enviar al menos un campo adicional a `id_ruta`.
- `nota` actualiza el campo `notas` en BD.

### Ejemplo request

```bash
curl -X PATCH "http://127.0.0.1:8000/updRuta" \
  -H "Authorization: Bearer TU_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "id_ruta": 3,
    "resultados": [
      {
        "id_agente": 6,
        "requisito": "paquetes_entregados",
        "resultado": "12"
      },
      {
        "id_agente": 6,
        "requisito": "comentarios",
        "resultado": "Cliente no estaba en domicilio"
      }
    ],
    "nota": "Cierre parcial de ruta"
  }'
```

### Ejemplo response

```json
{
  "status": "OK"
}
```

## GET /obtRutas

Lista rutas segun rol del usuario autenticado.

Autenticacion requerida:

- Bearer token (`Authorization: Bearer <token>`)

Reglas por rol:

- Owner (`rol = 1`): retorna todas las rutas.
- Admin (`rol = 2`): retorna rutas donde `ref = id` del admin autenticado.
- Agente (`rol = 3`): busca su registro en `agentes` y retorna rutas donde `ref = parther` del agente.

Filtros opcionales:

- `id_ruta`
- `zona`
- `ref`
- `cantidad`

### Ejemplo request

```bash
curl -X GET "http://127.0.0.1:8000/obtRutas?zona=Norte&cantidad=10" \
  -H "Authorization: Bearer TU_TOKEN"
```

### Ejemplo response

```json
{
  "Rutas": [
    {
      "id_ruta": 3,
      "ref": 4,
      "Zona": "Zona Norte",
      "Hora_Inicio": "08:00:00",
      "Hora_Final": "18:00:00",
      "Sectores": ["El Bosque", "La Soledad"],
      "Ubicacion_Inicial": {
        "lat": 10.251,
        "lng": -67.595
      },
      "Recaudos": ["comentarios", "paquetes_entregados"],
      "Agentes": null,
      "Resultados": null,
      "Notas": null
    }
  ]
}
```

## SQL tabla rutas (phpMyAdmin)

Archivo sugerido:

- `database/deploy/rutas.sql`

## POST /setConfig

Crea o actualiza la configuracion global (singleton).

Autenticacion requerida:

- Bearer token (`Authorization: Bearer <token>`)

Campos (todos opcionales en update):

- `hero_frase` (texto del hero)
- `hero_imagen` (archivo imagen)
- `micelines` (JSON con pares de informacion)
- `destacados` (JSON con pares de informacion)
- `banner[]` (una o varias imagenes)
- `comentarios` (JSON con varios comentarios)

Notas:

- Si no existe registro en `configs`, crea uno.
- Si ya existe, actualiza ese mismo registro.
- Si envias `hero_imagen`, reemplaza la imagen anterior.
- Si envias `banner[]`, reemplaza el banner anterior completo.
- Las imagenes se guardan en storage local y se sirven con URLs privadas firmadas en `/obtConfig`.

### Ejemplo request multipart

```bash
curl -X POST "http://127.0.0.1:8000/setConfig" \
  -H "Authorization: Bearer TU_TOKEN" \
  -F "hero_frase=Tu hogar ideal, sin complicaciones" \
  -F "hero_imagen=@/ruta/local/hero.jpg" \
  -F "micelines=[{\"titulo\":\"Rapidez\",\"valor\":\"48h\"}]" \
  -F "destacados=[{\"titulo\":\"Propiedades\",\"valor\":120}]" \
  -F "comentarios=[\"Excelente atencion\",\"Muy buen servicio\"]" \
  -F "banner[]=@/ruta/local/banner-1.jpg" \
  -F "banner[]=@/ruta/local/banner-2.jpg"
```

### Ejemplo response

```json
{
  "status": "OK"
}
```

## GET /obtConfig

Retorna toda la configuracion publica.
No requiere token.

Respuesta:

- `Hero` (`Frase`, `Imagen`)
- `MiCelines` (JSON)
- `Destacados` (JSON)
- `Banner` (URLs privadas firmadas)
- `Comentarios` (JSON)

### Ejemplo request

```bash
curl -X GET "http://127.0.0.1:8000/obtConfig"
```

### Ejemplo response

```json
{
  "Config": {
    "Hero": {
      "Frase": "Tu hogar ideal, sin complicaciones",
      "Imagen": "https://k7pr2wn9xm4tb6vl1zq8.info/media/config/hero.jpg?expires=1710531000&signature=abc123"
    },
    "MiCelines": [
      {
        "titulo": "Rapidez",
        "valor": "48h"
      }
    ],
    "Destacados": [
      {
        "titulo": "Propiedades",
        "valor": 120
      }
    ],
    "Banner": [
      "https://k7pr2wn9xm4tb6vl1zq8.info/media/config/banner-1.jpg?expires=1710531000&signature=def456"
    ],
    "Comentarios": [
      "Excelente atencion",
      "Muy buen servicio"
    ]
  }
}
```

## SQL tabla configs (phpMyAdmin)

Archivo sugerido:

- `database/deploy/configs.sql`

## POST /sendMsm

Envia mensajes a agentes.

Autenticacion requerida:

- Bearer token (`Authorization: Bearer <token>`)

Regla de rol:

- Solo Admin (`rol = 2`) puede enviar.

Campos:

- `sender` (requerido, debe ser el id del admin autenticado)
- `full` (requerido, `true` o `false`)
- `agentes` (array ids de agentes; requerido cuando `full=false`)
- `prioridad` (requerido: `baja`, `media`, `alta`, `urgente`)
- `titulo` (requerido)
- `mensaje` (requerido)

Comportamiento de `full`:

- `full=true`: ignora `agentes` y toma todos los agentes con `parther = sender`.
- `full=false`: usa solo los ids enviados en `agentes`.

### Ejemplo request (full=true)

```bash
curl -X POST "http://127.0.0.1:8000/sendMsm" \
  -H "Authorization: Bearer TU_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "sender": 4,
    "full": true,
    "prioridad": "alta",
    "titulo": "Reunion general",
    "mensaje": "Confirmar asistencia antes de las 4 PM"
  }'
```

### Ejemplo request (full=false)

```bash
curl -X POST "http://127.0.0.1:8000/sendMsm" \
  -H "Authorization: Bearer TU_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "sender": 4,
    "full": false,
    "agentes": [5, 6],
    "prioridad": "media",
    "titulo": "Ruta Zona Norte",
    "mensaje": "Actualizar resultados al cierre de jornada"
  }'
```

### Ejemplo response

```json
{
  "status": "OK"
}
```

## GET /obtMsm

Lista mensajes segun rol.

Autenticacion requerida:

- Bearer token (`Authorization: Bearer <token>`)

Reglas por rol:

- Owner (`rol = 1`): retorna todos los mensajes.
- Admin (`rol = 2`): retorna mensajes donde `sender = id` del admin autenticado.
- Agente (`rol = 3`): retorna mensajes donde su id de agente (o userLink) este incluido en `agentes`.

Filtros opcionales:

- `id_msm`
- `sender`
- `prioridad`
- `cantidad`

### Ejemplo request

```bash
curl -X GET "http://127.0.0.1:8000/obtMsm?prioridad=alta&cantidad=20" \
  -H "Authorization: Bearer TU_TOKEN"
```

### Ejemplo response

```json
{
  "Mensajes": [
    {
      "id_msm": 9,
      "Sender": 4,
      "Full": false,
      "Agentes": [5, 6],
      "Prioridad": "media",
      "Titulo": "Ruta Zona Norte",
      "Mensaje": "Actualizar resultados al cierre de jornada",
      "Creado_En": "2026-03-19 10:40:00"
    }
  ]
}
```

## SQL tabla mensajes (phpMyAdmin)

Archivo sugerido:

- `database/deploy/mensajes.sql`

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

## POST /push/subscribe

Guarda o actualiza la suscripcion Web Push de un dispositivo.

Requiere Bearer token (`Authorization: Bearer <token>`).

El servidor toma el usuario del token y lo guarda en `push_subscriptions.user_id`.

Campos:

- `deviceId` (requerido)
- `subscription.endpoint` (requerido)
- `subscription.keys.p256dh` (requerido)
- `subscription.keys.auth` (requerido)

### Ejemplo request

```bash
curl -X POST "https://tu-dominio.com/push/subscribe" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer TU_TOKEN" \
  -d '{
    "deviceId": "ios-17-prueba-1",
    "subscription": {
      "endpoint": "https://web.push.apple.com/...",
      "keys": {
        "p256dh": "BASE64URL_P256DH",
        "auth": "BASE64URL_AUTH"
      }
    }
  }'
```

### Ejemplo response

```json
{
  "status": "OK"
}
```

## POST /push/send-test

Envia una notificacion de prueba al `deviceId` enviado.

No requiere Bearer; se protege con header:

- `X-Push-Token: <PUSH_TEST_TOKEN>`

Campos:

- `deviceId` (requerido)
- `title` (requerido)
- `body` (requerido)
- `url` (opcional)

### Ejemplo request

```bash
curl -X POST "https://tu-dominio.com/push/send-test" \
  -H "Content-Type: application/json" \
  -H "X-Push-Token: TU_TOKEN_SECRETO" \
  -d '{
    "deviceId":"ios-17-prueba-1",
    "title":"Prueba iOS 17",
    "body":"Hola desde Laravel",
    "url":"/"
  }'
```

### Ejemplo response

```json
{
  "status": "OK",
  "sent_to": 1,
  "success": 1,
  "failed": 0
}
```

## SQL tabla push_subscriptions (phpMyAdmin)

Archivo sugerido:

- `database/deploy/push_subscriptions.sql`

Variables `.env` requeridas:

- `WEB_PUSH_VAPID_PUBLIC_KEY`
- `WEB_PUSH_VAPID_PRIVATE_KEY`
- `WEB_PUSH_VAPID_SUBJECT`
- `PUSH_TEST_TOKEN`

## POST /loans

Crea un prestamo y genera automaticamente sus cortes.

Autenticacion requerida para todos los endpoints de prestamos:

- Bearer token (`Authorization: Bearer <token>`)
- Usuario con `rol = 8` (si no, responde `403`)
- Al crear se guarda `id_owner` con el `id` del usuario del token
- Listar/actualizar/eliminar solo opera sobre prestamos con `id_owner = id` del token

Body JSON:

- `fullName` (requerido)
- `documentId` (requerido)
- `principalUnit` (requerido)
- `cutFrequency` (requerido: `mensual`, `quincenal`, `semanal`)
- `termValue` (requerido)
- `ratePerCut` (requerido)
- `startDate` (requerido, formato `Y-m-d`)

### Ejemplo request

```bash
curl -X POST "http://127.0.0.1:8000/loans" \
  -H "Authorization: Bearer TU_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "fullName": "Andrea Soto",
    "documentId": "V-18299311",
    "principalUnit": 1000,
    "cutFrequency": "mensual",
    "termValue": 3,
    "ratePerCut": 10,
    "startDate": "2026-03-21"
  }'
```

## GET /loans

Lista prestamos (incluye cortes).

Query params opcionales:

- `search`
- `status`

### Ejemplo request

```bash
curl -X GET "http://127.0.0.1:8000/loans?search=soto" \
  -H "Authorization: Bearer TU_TOKEN"
```

## PATCH /loans/{id}

Aplica acciones sobre el prestamo con campo `action`.

Acciones:

- `update_loan` (legacy)
- `pay_cut`
- `extend_cut`
- `penalize_cut`

### Ejemplo pay_cut (multipart)

```bash
curl -X PATCH "http://127.0.0.1:8000/loans/15" \
  -H "Authorization: Bearer TU_TOKEN" \
  -F "action=pay_cut" \
  -F "cutId=44" \
  -F "note=Pago confirmado" \
  -F "proof=@/ruta/local/comprobante.jpg"
```

## PATCH /loans/{id}/data

Actualiza solo datos del prestamo (no cortes).

Campos (al menos uno):

- `fullName` (opcional)
- `documentId` (opcional)
- `status` (opcional: `active`, `completed`, `cancelled`)

### Ejemplo request

```bash
curl -X PATCH "http://127.0.0.1:8000/loans/15/data" \
  -H "Authorization: Bearer TU_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "fullName": "Andrea Soto Actualizada",
    "documentId": "V-18299311"
  }'
```

## DELETE /loans/{id}

Elimina el prestamo completo (prestamo + cortes). Tambien limpia notificaciones push asociadas a ese prestamo/cortes.

### Ejemplo request

```bash
curl -X DELETE "http://127.0.0.1:8000/loans/15" \
  -H "Authorization: Bearer TU_TOKEN"
```

Notas:

- Existen alias equivalentes bajo `/api/loans`:
  - `POST /api/loans`
  - `GET /api/loans`
  - `PATCH /api/loans/{id}`
  - `PATCH /api/loans/{id}/data`
  - `DELETE /api/loans/{id}`

## SQL tablas loans / loan_cuts (phpMyAdmin)

Archivo sugerido:

- `database/deploy/loans.sql`
- `database/deploy/loan_owner_patch.sql` (patch para BD existente)

## POST /setPushConfig

Configura o pausa la automatizacion de notificaciones push de prestamos.

Autenticacion:

- No requiere token.

Campos (todos opcionales, pero debe venir al menos 1):

- `enabled` (`true|false`): activa/desactiva el sistema automatico
- `paused` (`true|false`): pausa/reanuda
- `pauseUntil` (fecha/hora): pausa hasta esta fecha
- `pauseMinutes` (entero): pausa por N minutos (atajo)
- `preDueDays` (json array): dias previos para avisar (ej: `[3,2,1]`)
- `preDueHour` (0-23): hora para generar avisos 3/2/1
- `dueMorningStartHour`, `dueMorningEndHour`
- `dueAfternoonStartHour`, `dueAfternoonEndHour`
- `spreadSeconds`: separacion entre notificaciones en cola
- `dispatchBatchSize`: tamano de lote por minuto
- `retryDelayMinutes`: minutos de reintento
- `maxAttempts`: maximo de reintentos

### Ejemplo request

```bash
curl -X POST "https://tu-dominio.com/setPushConfig" \
  -H "Content-Type: application/json" \
  -d '{
    "enabled": true,
    "paused": false,
    "preDueDays": [3,2,1],
    "preDueHour": 9,
    "spreadSeconds": 25,
    "dispatchBatchSize": 100
  }'
```

### Ejemplo response

```json
{
  "status": "OK",
  "Config": {
    "enabled": true,
    "paused": false,
    "pauseUntil": null,
    "preDueDays": [3,2,1],
    "preDueHour": 9,
    "dueMorningStartHour": 7,
    "dueMorningEndHour": 11,
    "dueAfternoonStartHour": 14,
    "dueAfternoonEndHour": 18,
    "spreadSeconds": 20,
    "dispatchBatchSize": 100,
    "retryDelayMinutes": 5,
    "maxAttempts": 3,
    "dispatchEnabledNow": true
  }
}
```

## GET /obtPushConfig

Devuelve la configuracion actual del sistema de push automatico.

Autenticacion:

- No requiere token.

### Ejemplo request

```bash
curl -X GET "https://tu-dominio.com/obtPushConfig"
```

## GET /obtPushMonitor

Monitoreo en texto plano (sin UI), util para validar cola/envio/errores.

Autenticacion:

- No requiere token.

Query params opcional:

- `limit` (1-200) cantidad de filas en secciones de monitoreo

### Ejemplo request

```bash
curl -X GET "https://tu-dominio.com/obtPushMonitor?limit=30"
```

### Ejemplo response (texto)

```text
PUSH MONITOR
generated_at: 2026-03-21 20:15:00
enabled: true
paused: false
...
NEXT PENDING (max 30)
#12 | user:8 | pre_due_3 | loan:5 cut:18 | at:2026-03-21 20:15:20 | attempts:0 | Recordatorio de corte
...
```

## Automatizacion Push (Prestamos)

Comportamiento automatico implementado:

- Cada notificacion se asocia al usuario dueno del prestamo (`loans.id_owner`) y solo se envia a sus suscripciones (`push_subscriptions.user_id`).
- La URL se construye usando `users.url` del dueno del prestamo como base.
- Avisa cuando faltan `3`, `2` y `1` dias para el corte (a la hora `preDueHour`).
- El dia de cobro envia recordatorio cada hora en ventanas:
- `07:00 - 11:00`
- `14:00 - 18:00`
- Distribuye envios con `spreadSeconds` para evitar burst al mismo segundo.
- Reintenta fallos segun `retryDelayMinutes` y `maxAttempts`.

Comandos manuales utiles:

```bash
php artisan push:auto-plan
php artisan push:auto-dispatch
php artisan push:auto-cycle
```

Scheduler Laravel (automatico):

- `push:auto-plan` corre cada hora
- `push:auto-dispatch` corre cada minuto

Importante en servidor (cron):

```bash
* * * * * cd /var/www/smarthouse-api && php artisan schedule:run >> /dev/null 2>&1
```

## SQL tablas push automation

Archivos sugeridos:

- `database/deploy/push_automation.sql` (instalacion nueva)
- `database/deploy/push_notifications_user_patch.sql` (BD existente: agrega `user_id` + FK en `push_notifications`)
- `database/deploy/push_subscriptions_user_patch.sql` (BD existente: agrega `user_id` + FK en `push_subscriptions`)
