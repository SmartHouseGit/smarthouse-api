# API Routes

Base URL local:

```
http://127.0.0.1:8000
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
- `imagen_referencial` (texto o archivo)
- `mensaje`

### Ejemplo request JSON

```bash
curl -X POST "http://127.0.0.1:8000/publicarIn" \
  -H "Content-Type: application/json" \
  -d '{
    "nombre": "Maria Gomez",
    "telefono": "+584121234567",
    "ciudad": "Valencia",
    "zona": "Prebo",
    "tipo_inmueble": "Apartamento",
    "imagen_referencial": "https://mi-cdn.com/inmueble.jpg",
    "mensaje": "Deseo publicar este inmueble."
  }'
```

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
- `datos_especificos` (objeto JSON)
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

### Ejemplo request JSON

```bash
curl -X POST "http://127.0.0.1:8000/setPropiedades" \
  -H "Content-Type: application/json" \
  -d '{
    "id_publico": "PUB-0001",
    "nombre": "Residencias El Bosque",
    "tagline": "Ubicacion premium y excelente retorno",
    "ciudad_estado": "Valencia, Carabobo",
    "tipo_inmueble": "Apartamento",
    "precio": 125000,
    "estado_interno": "disponible",
    "estado_publico": "publicado",
    "detalles": "Apartamento en excelente zona, cerca de centros comerciales.",
    "id_agente": 1,
    "propietario": 101,
    "coordenadas": {
      "latitud": 10.1620,
      "longitud": -68.0077
    },
    "datos_especificos": {
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
    "foto_principal": "https://mi-cdn.com/propiedades/p-1-main.jpg",
    "fotos_secundarias": [
      "https://mi-cdn.com/propiedades/p-1-2.jpg",
      "https://mi-cdn.com/propiedades/p-1-3.jpg"
    ]
  }'
```

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
        "principal": "https://mi-cdn.com/propiedades/p-1-main.jpg",
        "secundarias": [
          "https://mi-cdn.com/propiedades/p-1-2.jpg",
          "https://mi-cdn.com/propiedades/p-1-3.jpg"
        ]
      }
    }
  ]
}
```

## GET /obtAgentes

Lista agentes. Filtros opcionales:

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
      "Foto_Portada": "https://mi-cdn.com/agentes/portada-1.jpg",
      "Foto_Perfil": "https://mi-cdn.com/agentes/perfil-1.jpg",
      "Nombre": "Valentina",
      "Apellido": "Rojas",
      "Telefono": "+584121234567",
      "Descripcion_Breve": "Asesora comercial con enfoque en inmuebles residenciales."
    }
  ]
}
```

## POST /setAgente

Crea un agente nuevo.

Campos:

- `foto_portada`
- `foto_perfil`
- `nombre`
- `apellido`
- `telefono`
- `descripcion_breve`

### Ejemplo request JSON

```bash
curl -X POST "http://127.0.0.1:8000/setAgente" \
  -H "Content-Type: application/json" \
  -d '{
    "foto_portada": "https://mi-cdn.com/agentes/portada-1.jpg",
    "foto_perfil": "https://mi-cdn.com/agentes/perfil-1.jpg",
    "nombre": "Valentina",
    "apellido": "Rojas",
    "telefono": "+584121234567",
    "descripcion_breve": "Asesora comercial con enfoque en inmuebles residenciales."
  }'
```

### Ejemplo request multipart (archivo)

```bash
curl -X POST "http://127.0.0.1:8000/setAgente" \
  -F "foto_portada=@/ruta/local/portada.jpg" \
  -F "foto_perfil=@/ruta/local/perfil.jpg" \
  -F "nombre=Valentina" \
  -F "apellido=Rojas" \
  -F "telefono=+584121234567" \
  -F "descripcion_breve=Asesora comercial con enfoque en inmuebles residenciales."
```

### Ejemplo response

```json
{
  "status": "OK"
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

Lista clientes. Filtros opcionales:

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
curl -X GET "http://127.0.0.1:8000/obtClientes?ciudad=Valencia&tipo=Comprador&agente_res=1&cantidad=20"
```

### Ejemplo response

```json
{
  "Clientes": [
    {
      "id_cliente": 1,
      "Foto": "https://mi-cdn.com/clientes/foto-1.jpg",
      "Portada": "https://mi-cdn.com/clientes/portada-1.jpg",
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
- `agente_res` (id del agente responsable)

### Ejemplo request JSON

```bash
curl -X POST "http://127.0.0.1:8000/setCliente" \
  -H "Content-Type: application/json" \
  -d '{
    "foto": "https://mi-cdn.com/clientes/foto-1.jpg",
    "portada": "https://mi-cdn.com/clientes/portada-1.jpg",
    "nombre": "Carlos Rojas",
    "perfil": "Cliente interesado en compra de apartamento familiar.",
    "tipo": "Comprador",
    "estado": "Activo",
    "telefono": "+584141112233",
    "correo": "carlos@email.com",
    "direccion": "Av. Principal, Valencia",
    "ciudad": "Valencia",
    "documento_rif": "V-12345678",
    "notas": "Prefiere zona norte.",
    "agente_res": 1
  }'
```

### Ejemplo request multipart (archivo)

```bash
curl -X POST "http://127.0.0.1:8000/setCliente" \
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
  -F "notas=Prefiere zona norte." \
  -F "agente_res=1"
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
