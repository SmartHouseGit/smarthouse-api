/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.8.3-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: 127.0.0.1    Database: smarthouse_api
-- ------------------------------------------------------
-- Server version	11.8.3-MariaDB-0+deb13u1 from Debian

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `admins` (
  `id_admin` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `userLink` bigint(20) unsigned NOT NULL,
  `parther` int(10) NOT NULL,
  `foto_portada` varchar(500) DEFAULT NULL,
  `foto_perfil` varchar(500) DEFAULT NULL,
  `nombre` varchar(120) NOT NULL,
  `apellido` varchar(120) NOT NULL,
  `telefono` varchar(40) NOT NULL,
  `descripcion_breve` text NOT NULL,
  PRIMARY KEY (`id_admin`),
  UNIQUE KEY `uq_admins_userlink` (`userLink`),
  KEY `idx_admins_nombre` (`nombre`),
  KEY `idx_admins_apellido` (`apellido`),
  KEY `idx_admins_telefono` (`telefono`),
  CONSTRAINT `fk_admins_users` FOREIGN KEY (`userLink`) REFERENCES `users` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `admins` VALUES
(1,4,0,NULL,NULL,'Laura','Mendoza','+584149998877','Admin senior de operaciones.');
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `agentes`
--

DROP TABLE IF EXISTS `agentes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `agentes` (
  `id_agente` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `userLink` int(10) NOT NULL,
  `parther` int(10) NOT NULL,
  `foto_portada` varchar(500) DEFAULT NULL,
  `foto_perfil` varchar(500) DEFAULT NULL,
  `nombre` varchar(120) NOT NULL,
  `apellido` varchar(120) NOT NULL,
  `telefono` varchar(40) NOT NULL,
  `descripcion_breve` text NOT NULL,
  PRIMARY KEY (`id_agente`),
  KEY `idx_agentes_nombre` (`nombre`),
  KEY `idx_agentes_apellido` (`apellido`),
  KEY `idx_agentes_telefono` (`telefono`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agentes`
--

LOCK TABLES `agentes` WRITE;
/*!40000 ALTER TABLE `agentes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `agentes` VALUES
(1,0,0,'https://mi-cdn.com/agentes/portada-1.jpg','https://mi-cdn.com/agentes/perfil-1.jpg','Ramona','Rojas','+584121234567','Asesora comercial con enfoque en inmuebles residenciales.'),
(2,0,0,'https://mi-cdn.com/agentes/portada-2.jpg','https://mi-cdn.com/agentes/perfil-2.jpg','Aup','Mendoza','+584148887766','Especialista en cierre de operaciones y negociacion inmobiliaria.'),
(4,2,0,NULL,NULL,'Mis huevos','Redondos','+584121234567','Asesora comercial con enfoque en inmuebles residenciales.'),
(5,5,4,NULL,NULL,'Luis','Mora','+584149998877','Asesor inmobiliario');
/*!40000 ALTER TABLE `agentes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_locks_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_locks`
--

LOCK TABLES `cache_locks` WRITE;
/*!40000 ALTER TABLE `cache_locks` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `cache_locks` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `ciudades`
--

DROP TABLE IF EXISTS `ciudades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ciudades` (
  `id_ciudad` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(120) NOT NULL,
  PRIMARY KEY (`id_ciudad`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ciudades`
--

LOCK TABLES `ciudades` WRITE;
/*!40000 ALTER TABLE `ciudades` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ciudades` VALUES
(3,'Caracas'),
(1,'Maracay'),
(2,'Valencia'),
(4,'Villa de cura');
/*!40000 ALTER TABLE `ciudades` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `id_cliente` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `foto` varchar(500) NOT NULL,
  `portada` varchar(500) NOT NULL,
  `nombre` varchar(180) NOT NULL,
  `perfil` text NOT NULL,
  `tipo` varchar(100) NOT NULL,
  `estado` varchar(100) NOT NULL,
  `telefono` varchar(40) NOT NULL,
  `correo` varchar(180) NOT NULL,
  `direccion` varchar(255) NOT NULL,
  `ciudad` varchar(120) NOT NULL,
  `documento_rif` varchar(60) NOT NULL,
  `notas` text DEFAULT NULL,
  `agente_res` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id_cliente`),
  KEY `idx_clientes_nombre` (`nombre`),
  KEY `idx_clientes_tipo` (`tipo`),
  KEY `idx_clientes_estado` (`estado`),
  KEY `idx_clientes_ciudad` (`ciudad`),
  KEY `idx_clientes_correo` (`correo`),
  KEY `idx_clientes_agente_res` (`agente_res`),
  CONSTRAINT `fk_clientes_agentes` FOREIGN KEY (`agente_res`) REFERENCES `agentes` (`id_agente`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `contactos`
--

DROP TABLE IF EXISTS `contactos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `contactos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tipo` tinyint(3) unsigned NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `email` varchar(150) NOT NULL,
  `objetivo` varchar(255) NOT NULL,
  `mensaje` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_contactos_email` (`email`),
  CONSTRAINT `chk_contactos_tipo` CHECK (`tipo` in (1,2))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contactos`
--

LOCK TABLES `contactos` WRITE;
/*!40000 ALTER TABLE `contactos` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `contactos` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_batches`
--

LOCK TABLES `job_batches` WRITE;
/*!40000 ALTER TABLE `job_batches` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `job_batches` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_reserved_at_available_at_index` (`queue`,`reserved_at`,`available_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `migrations` VALUES
(1,'0001_01_01_000000_create_users_table',1),
(2,'0001_01_01_000001_create_cache_table',1),
(3,'0001_01_01_000002_create_jobs_table',1),
(4,'2026_03_13_215330_create_personal_access_tokens_table',2);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` text NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  KEY `personal_access_tokens_expires_at_index` (`expires_at`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `personal_access_tokens` VALUES
(1,'App\\Models\\User',2,'frontend','35538bd42738d50b60dad6716facfc378c931b981ee18ce6656221e7a92e4bcc','[\"*\"]',NULL,NULL,'2026-03-17 23:27:02','2026-03-17 23:27:02'),
(2,'App\\Models\\User',4,'frontend','de5a7388ac96e5205157742c4557498cd56a204cfac13f5431681fd24882401a','[\"*\"]','2026-03-17 23:54:48',NULL,'2026-03-17 23:52:35','2026-03-17 23:54:48'),
(3,'App\\Models\\User',4,'frontend','b264b02de906b9a815efe3ffb2ca6bcff0217227efad7859a9e8f96d01653818','[\"*\"]',NULL,NULL,'2026-03-18 00:35:35','2026-03-18 00:35:35'),
(4,'App\\Models\\User',4,'frontend','30b3451cf50c103a5292292cd0933a4b1a98fdb2636d966e5dc12e4cd7c7fd92','[\"*\"]',NULL,NULL,'2026-03-18 00:55:22','2026-03-18 00:55:22');
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `propiedades`
--

DROP TABLE IF EXISTS `propiedades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `propiedades` (
  `id_interno` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `id_publico` varchar(100) NOT NULL,
  `nombre` varchar(180) NOT NULL,
  `tagline` varchar(255) NOT NULL,
  `ciudad_estado` varchar(180) NOT NULL,
  `tipo_inmueble` varchar(120) NOT NULL,
  `precio` decimal(14,2) NOT NULL,
  `estado_interno` varchar(120) NOT NULL,
  `estado_publico` varchar(120) NOT NULL,
  `detalles` text NOT NULL,
  `datos_especificos` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`datos_especificos`)),
  `id_agente` bigint(20) unsigned NOT NULL,
  `propietario` bigint(20) unsigned DEFAULT NULL,
  `latitud` decimal(10,7) NOT NULL,
  `longitud` decimal(10,7) NOT NULL,
  `foto_principal` varchar(500) NOT NULL,
  `fotos_secundarias` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`fotos_secundarias`)),
  PRIMARY KEY (`id_interno`),
  UNIQUE KEY `id_publico` (`id_publico`),
  KEY `idx_propiedades_ciudad_estado` (`ciudad_estado`),
  KEY `idx_propiedades_tipo` (`tipo_inmueble`),
  KEY `idx_propiedades_precio` (`precio`),
  KEY `idx_propiedades_estado_publico` (`estado_publico`),
  KEY `idx_propiedades_estado_interno` (`estado_interno`),
  KEY `idx_propiedades_tagline` (`tagline`),
  KEY `idx_propiedades_id_agente` (`id_agente`),
  KEY `idx_propiedades_propietario` (`propietario`),
  CONSTRAINT `fk_propiedades_agentes` FOREIGN KEY (`id_agente`) REFERENCES `agentes` (`id_agente`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `propiedades`
--

LOCK TABLES `propiedades` WRITE;
/*!40000 ALTER TABLE `propiedades` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `propiedades` VALUES
(1,'PUB-0001','Residencias El Bosque','Residencias El Bosque','Valencia, Carabobo','Apartamento',125000.00,'disponible','publicado','Apartamento en excelente zona, cerca de centros comerciales.','{\"dormitorios\":3,\"banos\":2,\"area_m2\":110,\"estacionamientos\":2,\"con_piscina\":true,\"pet_friendly\":true,\"ano_construccion\":2018,\"amoblada\":false,\"balcon\":true,\"seguridad_privada\":true,\"financiable\":true}',1,NULL,10.1620000,-68.0077000,'https://mi-cdn.com/propiedades/p-1-main.jpg','[\"https://mi-cdn.com/propiedades/p-1-2.jpg\",\"https://mi-cdn.com/propiedades/p-1-3.jpg\"]'),
(2,'PUB-0002','Casa Los Naranjos','Casa Los Naranjos','Caracas, Distrito Capital','Casa',185000.00,'disponible','publicado','Casa de dos niveles, remodelada, con buena ventilacion.','{\"dormitorios\":4,\"banos\":3,\"area_m2\":220,\"estacionamientos\":2,\"con_piscina\":false,\"pet_friendly\":true,\"ano_construccion\":2012,\"amoblada\":false,\"balcon\":true,\"seguridad_privada\":true,\"financiable\":true}',1,NULL,10.4806000,-66.9036000,'https://mi-cdn.com/propiedades/p-2-main.jpg','[\"https://mi-cdn.com/propiedades/p-2-2.jpg\",\"https://mi-cdn.com/propiedades/p-2-3.jpg\"]');
/*!40000 ALTER TABLE `propiedades` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `publicar_ins`
--

DROP TABLE IF EXISTS `publicar_ins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `publicar_ins` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) NOT NULL,
  `telefono` varchar(30) NOT NULL,
  `ciudad` varchar(120) NOT NULL,
  `zona` varchar(120) NOT NULL,
  `tipo_inmueble` varchar(150) NOT NULL,
  `imagen_referencial` varchar(500) NOT NULL,
  `mensaje` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_publicar_ciudad_zona` (`ciudad`,`zona`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publicar_ins`
--

LOCK TABLES `publicar_ins` WRITE;
/*!40000 ALTER TABLE `publicar_ins` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `publicar_ins` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sessions` VALUES
('16wA63n1nyVyupUXPsiIvP0OqCDg1vxzKEXYLXhB',NULL,'127.0.0.1','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiN2dvUkJZeHEwRmxTQlN0allENHNkdGQ4TG4zSll5akM4QWZ5ek82YyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9zdGFydCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1773436828);
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `solicitar_ins`
--

DROP TABLE IF EXISTS `solicitar_ins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `solicitar_ins` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) NOT NULL,
  `telefono` varchar(30) NOT NULL,
  `ciudad` varchar(120) NOT NULL,
  `zona` varchar(120) NOT NULL,
  `tipo_inmueble` varchar(150) NOT NULL,
  `presupuesto` decimal(14,2) NOT NULL,
  `mensaje` text NOT NULL,
  `datos_especificos` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`datos_especificos`)),
  PRIMARY KEY (`id`),
  KEY `idx_solicitar_ciudad_zona` (`ciudad`,`zona`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `solicitar_ins`
--

LOCK TABLES `solicitar_ins` WRITE;
/*!40000 ALTER TABLE `solicitar_ins` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `solicitar_ins` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `testimonios`
--

DROP TABLE IF EXISTS `testimonios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `testimonios` (
  `id_testimonio` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) NOT NULL,
  `localizacion` varchar(120) NOT NULL,
  `testimonio` text NOT NULL,
  PRIMARY KEY (`id_testimonio`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `testimonios`
--

LOCK TABLES `testimonios` WRITE;
/*!40000 ALTER TABLE `testimonios` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `testimonios` VALUES
(1,'Valentina Rojas','Maracay','En menos de dos meses consolidamos dos operaciones en Caracas y Valencia. El nivel de respuesta, orden documental y acompañamiento comercial fue extraordinario.'),
(2,'Pedro Rojas','Valencia','Con su acompañamiento logramos cerrar una compra compleja sin desviarnos del presupuesto objetivo. Excelente criterio comercial y financiero.');
/*!40000 ALTER TABLE `testimonios` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `rol` int(10) NOT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `users` VALUES
(2,'Mis huevos Redondos','agente_test_01@smarthouse.local',NULL,3,'$2y$12$.Xq5bJ7Flzd6fcmESFW69.2kJ.m2Y5VN5Kw48UuDPrqUhDzgrLeyK',NULL,'2026-03-17 23:26:18','2026-03-17 23:26:18'),
(4,'Laura Mendoza','admin@a.a',NULL,2,'$2y$12$jd8CdHgY33NvHxkTl6VE6.dzQ235P2HQeK34IyH3uog0OVZIsB1km',NULL,'2026-03-17 23:43:14','2026-03-17 23:43:14'),
(5,'Luis Mora','3',NULL,3,'$2y$12$Ii9N6HD3LtYVp/EtFpM4oO2hOLAr/FzDyDlaQ9rlcdHlojG24KoDS',NULL,'2026-03-17 23:54:13','2026-03-17 23:54:13');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping routines for database 'smarthouse_api'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2026-03-18 18:27:00
