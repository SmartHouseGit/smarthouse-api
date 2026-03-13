# Deploy Laravel API (Ubuntu VPS limpio)

Esta guía deja una API Laravel funcionando en un VPS Ubuntu desde cero, con MariaDB y Apache, evitando los errores que ya vimos.

## 1) Conectarse al VPS y actualizar sistema

```bash
ssh usuario@IP_DEL_VPS
```
Conecta por SSH al servidor.

```bash
sudo apt update && sudo apt upgrade -y
```
Actualiza índices de paquetes y aplica actualizaciones base del sistema.

## 2) Instalar stack mínimo (PHP + Composer + MariaDB + Apache)

```bash
sudo apt install -y apache2 mariadb-server composer unzip git \
php php-cli libapache2-mod-php php-mysql php-mbstring php-xml php-curl php-zip
```
Instala servidor web, base de datos, gestor de dependencias PHP y extensiones requeridas por Laravel.

```bash
sudo systemctl enable --now apache2 mariadb
```
Inicia Apache y MariaDB y los deja activos al reiniciar.

```bash
php -v && composer --version && mariadb --version
```
Verifica que PHP, Composer y MariaDB quedaron instalados.

## 3) Crear carpeta del proyecto y clonar código

```bash
sudo mkdir -p /var/www/smarthouse-api
```
Crea ruta estándar del proyecto en producción.

```bash
sudo chown -R $USER:$USER /var/www/smarthouse-api
```
Da permisos de escritura al usuario actual sobre la carpeta.

```bash
git clone URL_DE_TU_REPO /var/www/smarthouse-api
```
Descarga el proyecto en el servidor.

```bash
cd /var/www/smarthouse-api
```
Entra al proyecto.

## 4) Instalar dependencias Laravel y preparar entorno

```bash
composer install --no-dev --optimize-autoloader
```
Instala dependencias de producción.

```bash
cp .env.example .env
```
Crea archivo de configuración local.

```bash
php artisan key:generate
```
Genera la clave `APP_KEY`.

## 5) Crear base de datos y usuario (NO usar root en Laravel)

```bash
sudo mariadb -e "CREATE DATABASE IF NOT EXISTS smarthouse_api CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
```
Crea la base de datos.

```bash
sudo mariadb -e "DROP USER IF EXISTS 'smarthouse_user'@'localhost'; DROP USER IF EXISTS 'smarthouse_user'@'127.0.0.1';"
```
Elimina usuario previo para evitar credenciales rotas.

```bash
sudo mariadb -e "CREATE USER 'smarthouse_user'@'localhost' IDENTIFIED BY 'CambiaEstaClaveFuerte!'; CREATE USER 'smarthouse_user'@'127.0.0.1' IDENTIFIED BY 'CambiaEstaClaveFuerte!';"
```
Crea usuario de aplicación para socket local y conexión TCP.

```bash
sudo mariadb -e "GRANT ALL PRIVILEGES ON smarthouse_api.* TO 'smarthouse_user'@'localhost'; GRANT ALL PRIVILEGES ON smarthouse_api.* TO 'smarthouse_user'@'127.0.0.1'; FLUSH PRIVILEGES;"
```
Asigna permisos y recarga privilegios.

## 6) Configurar `.env` correctamente

Edita `.env` y deja estas líneas **sin `#`**:

```env
APP_ENV=production
APP_DEBUG=false
APP_URL=http://IP_DEL_VPS

DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=smarthouse_api
DB_USERNAME=smarthouse_user
DB_PASSWORD=CambiaEstaClaveFuerte!
```

Si las variables `DB_*` están comentadas, Laravel ignora esos valores y termina usando defaults (`root`, `laravel`).

## 7) Limpiar caché y migrar

```bash
php artisan optimize:clear
```
Limpia cachés de configuración/rutas/views para que Laravel relea `.env`.

```bash
php artisan migrate --force
```
Ejecuta migraciones en modo producción.

```bash
php artisan tinker --execute="dump(config('database.connections.mysql.host'), config('database.connections.mysql.database'), config('database.connections.mysql.username'));"
```
Verifica qué conexión está leyendo Laravel realmente.

## 8) Permisos correctos para Laravel

```bash
sudo chown -R www-data:www-data /var/www/smarthouse-api
```
Asigna el proyecto al usuario de Apache.

```bash
sudo chmod -R 775 /var/www/smarthouse-api/storage /var/www/smarthouse-api/bootstrap/cache
```
Da permisos de escritura donde Laravel lo necesita.

## 9) Configurar Apache para servir `public/`

```bash
sudo tee /etc/apache2/sites-available/smarthouse-api.conf > /dev/null <<'EOF'
<VirtualHost *:80>
    ServerName IP_DEL_VPS
    DocumentRoot /var/www/smarthouse-api/public

    <Directory /var/www/smarthouse-api/public>
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/smarthouse-api-error.log
    CustomLog ${APACHE_LOG_DIR}/smarthouse-api-access.log combined
</VirtualHost>
EOF
```
Crea virtual host apuntando al `public/` de Laravel.

```bash
sudo a2enmod rewrite
```
Activa `mod_rewrite`, necesario para rutas Laravel.

```bash
sudo a2dissite 000-default.conf && sudo a2ensite smarthouse-api.conf
```
Desactiva sitio default y activa el sitio de la API.

```bash
sudo systemctl reload apache2
```
Recarga Apache con la nueva configuración.

## 10) Probar despliegue

```bash
curl -I http://IP_DEL_VPS
```
Verifica que el sitio responde.

```bash
curl http://IP_DEL_VPS/up
```
Prueba endpoint de salud de Laravel.

## 11) (Opcional) Instalar phpMyAdmin

```bash
sudo apt install -y phpmyadmin
```
Instala phpMyAdmin.

```bash
sudo a2enconf phpmyadmin && sudo systemctl reload apache2
```
Publica phpMyAdmin en Apache.

Acceso: `http://IP_DEL_VPS/phpmyadmin`

## Problemas comunes y solución exacta

### Error: `Access denied for user 'root'@'localhost'`
- Causa: usar `root` en `.env`.
- Solución: usar `smarthouse_user`, limpiar caché y volver a migrar:

```bash
php artisan optimize:clear
php artisan migrate --force
```

### Laravel sigue leyendo valores viejos de DB
- Causa: cache de config.
- Solución:

```bash
php artisan optimize:clear
```

### Las variables DB en `.env` no aplican
- Causa: están comentadas (`# DB_HOST=...`).
- Solución: quitar `#` y validar con:

```bash
php artisan tinker --execute="dump(config('database.connections.mysql'));"
```

### `mysql-server` no disponible
- En Ubuntu normalmente sí existe.
- Si no existe en tu imagen, usa MariaDB (`mariadb-server`) como en esta guía.

## Comando de verificación final (todo en uno)

```bash
php -v && composer --version && mariadb --version && \
php artisan about && \
php artisan migrate:status
```
Confirma versiones, estado Laravel y estado de migraciones.
