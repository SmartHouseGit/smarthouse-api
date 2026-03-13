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
