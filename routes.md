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
- `ciudad_estado`
- `tipo_inmueble`
- `precio`
- `estado_interno`
- `estado_publico`
- `detalles`
- `agente_encargado`
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
    "ciudad_estado": "Valencia, Carabobo",
    "tipo_inmueble": "Apartamento",
    "precio": 125000,
    "estado_interno": "disponible",
    "estado_publico": "publicado",
    "detalles": "Apartamento en excelente zona, cerca de centros comerciales.",
    "agente_encargado": "Valentina Rojas",
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
  -F "ciudad_estado=Caracas, Distrito Capital" \
  -F "tipo_inmueble=Casa" \
  -F "precio=185000" \
  -F "estado_interno=disponible" \
  -F "estado_publico=publicado" \
  -F "detalles=Casa de dos niveles remodelada." \
  -F "agente_encargado=Pedro Rojas" \
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
- `ciudad_estado`
- `tipo_inmueble`
- `estado_interno`
- `estado_publico`
- `agente_encargado`
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
curl -X GET "http://127.0.0.1:8000/obtPropiedades?ciudad_estado=Valencia&tipo_inmueble=Apartamento&precio_min=100000&precio_max=180000&dormitorios=3&con_piscina=true&cantidad=20"
```

### Ejemplo response

```json
{
  "Propiedades": [
    {
      "id_interno": 1,
      "id_publico": "PUB-0001",
      "Nombre": "Residencias El Bosque",
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
      "Agente_Encargado": "Valentina Rojas",
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
