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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `admins` VALUES
(1,4,0,NULL,NULL,'Laura','Mendoza','+584149998877','Admin senior de operaciones.'),
(2,10,0,NULL,NULL,'Luis ','Bolivar','+584149998877','Admin senior de operaciones.');
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
  `userLink` bigint(20) unsigned NOT NULL,
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
  KEY `idx_agentes_telefono` (`telefono`),
  KEY `idx_agentes_userLink` (`userLink`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
(5,5,4,NULL,NULL,'Luis','Mora','+584149998877','Asesor inmobiliario'),
(6,6,4,NULL,NULL,'Raul','de Cervantes','+584243659965','buen vendedor'),
(7,7,4,NULL,NULL,'pedro','casanova','42566956856','Prof'),
(8,8,4,NULL,NULL,'Yonnel','Licon','04126789078','Yonnel'),
(9,9,4,NULL,NULL,'Yonnel12','Licon','041256789098','Yonnel Moises'),
(11,11,10,NULL,NULL,'Sara','Damasco','+584243073815','Buen Agente'),
(12,12,10,NULL,NULL,'Pepe','Alcaravan','+584243073956','Mejor Agenmte'),
(13,13,10,NULL,NULL,'Maria','Oropeza','+5755656584547','Sin notas add'),
(16,16,14,NULL,NULL,'Rafa','Pedromo','+58424665845','prueba');
/*!40000 ALTER TABLE `agentes` ENABLE KEYS */;
UNLOCK TABLES;
commit;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_uca1400_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`smarthouse_user`@`localhost`*/ /*!50003 TRIGGER `bi_agentes_sync_ids` BEFORE INSERT ON `agentes` FOR EACH ROW SET NEW.id_agente = NEW.userLink */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

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
INSERT INTO `cache` VALUES
('laravel-cache-illuminate:queue:restart','i:1774143070;',2089503070),
('laravel-cache-login|admin@sm.com|172.68.12.51','i:1;',1774280229),
('laravel-cache-login|admin@sm.com|172.68.12.51:timer','i:1774280229;',1774280229),
('laravel-cache-login|owner@sm.com|172.68.12.50','i:1;',1774280207),
('laravel-cache-login|owner@sm.com|172.68.12.50:timer','i:1774280207;',1774280207),
('laravel-cache-login|owner@sm.com|172.70.55.195','i:2;',1774280126),
('laravel-cache-login|owner@sm.com|172.70.55.195:timer','i:1774280126;',1774280126),
('laravel-cache-login|owner@sm.com|172.70.55.196','i:1;',1774280136),
('laravel-cache-login|owner@sm.com|172.70.55.196:timer','i:1774280136;',1774280136),
('laravel-cache-login|raul@sm.com|104.23.248.25','i:1;',1774280384),
('laravel-cache-login|raul@sm.com|104.23.248.25:timer','i:1774280384;',1774280384);
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
-- Table structure for table `cierres`
--

DROP TABLE IF EXISTS `cierres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `cierres` (
  `id_cierre` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ref` bigint(20) unsigned NOT NULL,
  `fecha` date NOT NULL,
  `tipo_cierre` varchar(30) NOT NULL,
  `estado_cierre` varchar(20) NOT NULL,
  `codigos_propiedades` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`codigos_propiedades`)),
  `titulo` varchar(180) NOT NULL,
  `precio_base` decimal(14,2) NOT NULL,
  `monto_cerrado` decimal(14,2) NOT NULL,
  `id_cliente` bigint(20) unsigned DEFAULT NULL,
  `ciudad` varchar(120) NOT NULL,
  `archivos` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`archivos`)),
  `nota` text DEFAULT NULL,
  PRIMARY KEY (`id_cierre`),
  KEY `idx_cierres_ref` (`ref`),
  KEY `idx_cierres_fecha` (`fecha`),
  KEY `idx_cierres_tipo` (`tipo_cierre`),
  KEY `idx_cierres_estado` (`estado_cierre`),
  KEY `idx_cierres_ciudad` (`ciudad`),
  KEY `idx_cierres_cliente` (`id_cliente`),
  CONSTRAINT `fk_cierres_agentes_ref` FOREIGN KEY (`ref`) REFERENCES `agentes` (`id_agente`) ON UPDATE CASCADE,
  CONSTRAINT `fk_cierres_clientes` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cierres`
--

LOCK TABLES `cierres` WRITE;
/*!40000 ALTER TABLE `cierres` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `cierres` VALUES
(1,6,'2026-03-19','Venta','Inicial',NULL,'Holas',2000.00,20000.00,4,'Maracay','[\"cierres\\/lvOEqbMHGSNFypdjlIGpafOcPKMEj4ecXuHBTA0C.pdf\"]','sjdsad'),
(2,12,'2026-03-19','Alquiler','Inicial',NULL,'prueba cierre',15000.00,20000.00,11,'Maracay',NULL,'prueba'),
(3,11,'2026-03-19','asesoria','Inicial',NULL,'prueba 2',15680.00,170000.00,7,'Caracas',NULL,'prueba');
/*!40000 ALTER TABLE `cierres` ENABLE KEYS */;
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
  CONSTRAINT `fk_clientes_agentes_userLink` FOREIGN KEY (`agente_res`) REFERENCES `agentes` (`userLink`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `clientes` VALUES
(1,'clientes/miehbg70QEX823Efzd1HbJlkf01y4L7ymYYuVwCR.png','clientes/q53mHiWUG6hCqKnsutlOnWvmk2ieIrXbxMEvKeW1.jpg','Yonnel','Comprador','Comprador','Activo','04124512048','Yonn@yon.com','Villa','Maracay','29659564','Yooooon',6),
(2,'clientes/miehbg70QEX823Efzd1HbJlkf01y4L7ymYYuVwCR.png','clientes/q53mHiWUG6hCqKnsutlOnWvmk2ieIrXbxMEvKeW1.jpg','Yonnelf','Comprador','Compradorg','Activog','04124512048','Yonn@yon.comg','Villa','Maracayfs','29659564','sffsfsf',5),
(3,'clientes/lU4ilDCRoswTGZPOhuNdc4BlCWJFGQJnFbbMDIld.png','clientes/QjwP3eyCl2L3AOwUVBXtUUNPeytijzlplvkp3b2s.jpg','NiñaCorp','Niña','Corporativo','Activo','04125627890','corp@niña.com','Niña','Valencia','78675432','Niñaaa',6),
(4,'clientes/aOpdLTh1ZccTTj3uUNjEZXrG8gp7vpEBQ1qfyLn9.png','clientes/NI7OR4PwpuiCpTVOA3pbUqZN3h8tG7vNvIj0DSlk.jpg','daso','daso','Comprador','Activo','0412345678','daso@gamil.com','daso','Maracay','1238213812123','daso',6),
(5,'clientes/vq5DdZRqCtUR296qBxFloXczZLlTSgJPMwEHwt3Q.png','clientes/x06BZoPyiDswJY0j1PXzSbVVuBTb5eTGce9fOsdl.jpg','nose','nose','Corporativo','Activo','04123503289','nose@gmail.com','nose','Caracas','83839393','nose',6),
(6,'clientes/vDLKe6IyeYOOruZaXYThrR0WQnFDSrKIRr1sqjv6.jpg','clientes/EyzJ8NcnjiERwBFkNiGFDEwJa4Ts8f7hE449guC2.jpg','Cliente 1','prueba cliente natural','Comprador','Activo','+584246956685','cliente1@sm.com','maracay','Maracay','12456865','Sin nota ocupable',11),
(7,'clientes/B9fXXHDejS0vETbZMLIEF8D2eRBycNVldyQT5unk.jpg','clientes/Ci9UHZCqDhRVbG0OZO32SDxyXQBuxQ7aaVTNIIhF.jpg','Corp 1','perfilde prueba corp','Corporativo','Activo','+575132454474','corp1@sm.com','bogota','bogota','457598158415','prueba corp 1',11),
(11,'clientes/LNrXGTaa2psJWJX5z14vvrCpleulHawrCipkw3sc.jpg','clientes/QdSSEsAUI6ermDCvmJEzoev0cV755VUm9tKEnpJ8.jpg','CLiente 6','prueba','Comprador','Activo','654984864646','cliente6@sm.com','sffefwe','Valencia','4816498','sin nota',12);
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `configs`
--

DROP TABLE IF EXISTS `configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `configs` (
  `id_config` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `hero_frase` text DEFAULT NULL,
  `hero_imagen` varchar(500) DEFAULT NULL,
  `micelines` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (`micelines` is null or json_valid(`micelines`)),
  `destacados` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (`destacados` is null or json_valid(`destacados`)),
  `banner` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (`banner` is null or json_valid(`banner`)),
  `comentarios` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (`comentarios` is null or json_valid(`comentarios`)),
  PRIMARY KEY (`id_config`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `configs`
--

LOCK TABLES `configs` WRITE;
/*!40000 ALTER TABLE `configs` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `configs` VALUES
(1,'Tu hogar ideal en un solo lugar','config/YSoo4OTV7uxaaMnL1WZjO1RuTZT4tEfPEweOCua6.jpg','[{\"titulo\":\"Holas a todos\",\"valor\":\"Hello mundo\"}]','[{\"titulo\":\"Casa espectacular\",\"valor\":\"1200\"}]','[\"config\\/AIJwYWurkE24d9uBfIQhbhT7Bn2CpVsW3SiUPBZR.jpg\"]','[{\"nombre\":\"Se\\u00f1or Jos\\u00e9\",\"subtitulo\":\"Lider\",\"comentario\":\"Casa espectacular, trato incre\\u00edble\"}]');
/*!40000 ALTER TABLE `configs` ENABLE KEYS */;
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
  `ref` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_contactos_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contactos`
--

LOCK TABLES `contactos` WRITE;
/*!40000 ALTER TABLE `contactos` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `contactos` VALUES
(1,1,'Yonn','Yonnn@gmail.com','Comprar para vivir','Prueba 1',11);
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
-- Table structure for table `loan_cuts`
--

DROP TABLE IF EXISTS `loan_cuts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `loan_cuts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) unsigned NOT NULL,
  `cut_number` int(10) unsigned NOT NULL,
  `original_due_date` date NOT NULL,
  `due_date` date NOT NULL,
  `base_amount` decimal(14,2) NOT NULL,
  `penalty_percent` decimal(8,2) NOT NULL DEFAULT 0.00,
  `amount` decimal(14,2) NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'pending',
  `note` text DEFAULT NULL,
  `proof_path` varchar(500) DEFAULT NULL,
  `paid_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_loan_cuts_loan_cut_number` (`loan_id`,`cut_number`),
  KEY `idx_loan_cuts_loan_id` (`loan_id`),
  KEY `idx_loan_cuts_status` (`status`),
  KEY `idx_loan_cuts_due_date` (`due_date`),
  CONSTRAINT `fk_loan_cuts_loans` FOREIGN KEY (`loan_id`) REFERENCES `loans` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loan_cuts`
--

LOCK TABLES `loan_cuts` WRITE;
/*!40000 ALTER TABLE `loan_cuts` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `loan_cuts` VALUES
(18,5,1,'2026-03-18','2026-03-21',350.00,0.00,350.00,'pending',NULL,NULL,NULL,'2026-03-22 01:32:51','2026-03-22 01:52:25'),
(19,5,2,'2026-05-21','2026-03-22',350.00,0.00,350.00,'pending',NULL,NULL,NULL,'2026-03-22 01:32:51','2026-03-22 01:56:03'),
(20,5,3,'2026-06-21','2026-03-23',350.00,0.00,350.00,'pending',NULL,NULL,NULL,'2026-03-22 01:32:51','2026-03-22 01:56:13'),
(21,5,4,'2026-07-21','2026-03-24',350.00,0.00,350.00,'pending',NULL,NULL,NULL,'2026-03-22 01:32:51','2026-03-22 01:56:24'),
(22,5,5,'2026-08-21','2026-03-25',10350.00,0.00,10350.00,'paid',NULL,'loans/proofs/BvEdf3DzwJXavfC3bQgy8IO8kCZcAFxIFgGgivBL.jpg','2026-03-21 22:10:53','2026-03-22 01:32:51','2026-03-21 22:10:53'),
(23,6,1,'2026-04-23','2026-04-23',5390.00,0.00,5390.00,'paid','Cancelo en efectivo en mi oficina','loans/proofs/Rc7ogdoUkYVl4f5Gkqgei9UaQFjxuZqUYvHuNdVQ.jpg','2026-03-23 12:11:11','2026-03-23 12:08:17','2026-03-23 12:11:11'),
(24,6,2,'2026-05-23','2026-05-23',5390.00,0.00,5390.00,'paid',NULL,'loans/proofs/jjDvg0I6BXWA2rTc545kPuYc6agAOUjyqXlO9wte.png','2026-03-23 21:01:10','2026-03-23 12:08:17','2026-03-23 21:01:10'),
(25,6,3,'2026-06-23','2026-06-23',5390.00,0.00,5390.00,'pending',NULL,NULL,NULL,'2026-03-23 12:08:17','2026-03-23 12:08:17'),
(26,6,4,'2026-07-23','2026-07-23',5390.00,0.00,5390.00,'pending',NULL,NULL,NULL,'2026-03-23 12:08:17','2026-03-23 12:08:17'),
(27,6,5,'2026-08-23','2026-08-23',82390.00,0.00,82390.00,'pending',NULL,NULL,NULL,'2026-03-23 12:08:17','2026-03-23 12:08:17'),
(28,7,1,'2026-05-01','2026-05-01',500.00,0.00,500.00,'pending',NULL,NULL,NULL,'2026-03-23 16:24:44','2026-03-23 16:24:44'),
(29,7,2,'2026-06-01','2026-06-01',500.00,0.00,500.00,'pending',NULL,NULL,NULL,'2026-03-23 16:24:44','2026-03-23 16:24:44'),
(30,7,3,'2026-07-01','2026-07-01',500.00,0.00,500.00,'pending',NULL,NULL,NULL,'2026-03-23 16:24:44','2026-03-23 16:24:44'),
(31,7,4,'2026-08-01','2026-08-01',500.00,0.00,500.00,'pending',NULL,NULL,NULL,'2026-03-23 16:24:44','2026-03-23 16:24:44'),
(32,7,5,'2026-09-01','2026-09-01',500.00,0.00,500.00,'pending',NULL,NULL,NULL,'2026-03-23 16:24:44','2026-03-23 16:24:44'),
(33,7,6,'2026-10-01','2026-10-01',500.00,0.00,500.00,'pending',NULL,NULL,NULL,'2026-03-23 16:24:44','2026-03-23 16:24:44'),
(34,7,7,'2026-11-01','2026-11-01',500.00,0.00,500.00,'pending',NULL,NULL,NULL,'2026-03-23 16:24:44','2026-03-23 16:24:44'),
(35,7,8,'2026-12-01','2026-12-01',500.00,0.00,500.00,'pending',NULL,NULL,NULL,'2026-03-23 16:24:44','2026-03-23 16:24:44'),
(36,7,9,'2027-01-01','2027-01-01',10500.00,0.00,10500.00,'pending',NULL,NULL,NULL,'2026-03-23 16:24:44','2026-03-23 16:24:44'),
(37,8,1,'2026-04-23','2026-04-23',100.00,0.00,100.00,'pending',NULL,NULL,NULL,'2026-03-23 20:13:11','2026-03-23 20:13:11'),
(38,8,2,'2026-05-23','2026-05-23',100.00,0.00,100.00,'pending',NULL,NULL,NULL,'2026-03-23 20:13:11','2026-03-23 20:13:11'),
(39,8,3,'2026-06-23','2026-06-23',100.00,0.00,100.00,'pending',NULL,NULL,NULL,'2026-03-23 20:13:11','2026-03-23 20:13:11'),
(40,8,4,'2026-07-23','2026-07-23',100.00,0.00,100.00,'pending',NULL,NULL,NULL,'2026-03-23 20:13:11','2026-03-23 20:13:11'),
(41,8,5,'2026-08-23','2026-08-23',1100.00,0.00,1100.00,'pending',NULL,NULL,NULL,'2026-03-23 20:13:11','2026-03-23 20:13:11'),
(42,9,1,'2026-04-23','2026-04-23',500.00,0.00,500.00,'pending',NULL,NULL,NULL,'2026-03-23 20:13:25','2026-03-23 20:13:25'),
(43,9,2,'2026-05-23','2026-05-23',500.00,0.00,500.00,'pending',NULL,NULL,NULL,'2026-03-23 20:13:25','2026-03-23 20:13:25'),
(44,9,3,'2026-06-23','2026-06-23',5500.00,0.00,5500.00,'pending',NULL,NULL,NULL,'2026-03-23 20:13:25','2026-03-23 20:13:25'),
(45,10,1,'2026-04-23','2026-04-23',20.00,0.00,20.00,'pending',NULL,NULL,NULL,'2026-03-23 20:17:54','2026-03-23 20:17:54'),
(46,10,2,'2026-05-23','2026-05-23',20.00,0.00,20.00,'pending',NULL,NULL,NULL,'2026-03-23 20:17:54','2026-03-23 20:17:54'),
(47,10,3,'2026-06-23','2026-06-23',1020.00,0.00,1020.00,'pending',NULL,NULL,NULL,'2026-03-23 20:17:54','2026-03-23 20:17:54'),
(48,11,1,'2026-04-23','2026-04-23',1000.00,0.00,1000.00,'paid',NULL,'loans/proofs/Kr0bOYjngE9RbhNQk8YMITkckS0fPnwsFMbGnI84.png','2026-03-23 21:01:43','2026-03-23 21:01:32','2026-03-23 21:01:43'),
(49,11,2,'2026-05-23','2026-05-23',1000.00,0.00,1000.00,'paid',NULL,'loans/proofs/oifA71iJJ1SpfBp1PD3EKpiT8pPrcO2hiDKDRU1G.png','2026-03-23 21:01:48','2026-03-23 21:01:32','2026-03-23 21:01:48'),
(50,11,3,'2026-06-23','2026-06-23',11000.00,0.00,11000.00,'paid',NULL,'loans/proofs/2QgPsP3kfdH4jld2jJjZAPc8cLzxOL2KQaoTTvoZ.png','2026-03-23 21:01:52','2026-03-23 21:01:32','2026-03-23 21:01:52');
/*!40000 ALTER TABLE `loan_cuts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `loans`
--

DROP TABLE IF EXISTS `loans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `loans` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `full_name` varchar(180) NOT NULL,
  `document_id` varchar(80) NOT NULL,
  `principal_amount` decimal(14,2) NOT NULL,
  `cut_frequency` varchar(20) NOT NULL,
  `term_cuts` int(10) unsigned NOT NULL,
  `rate_per_cut` decimal(8,4) NOT NULL,
  `per_cut_amount` decimal(14,2) NOT NULL,
  `final_cut_amount` decimal(14,2) NOT NULL,
  `total_gain` decimal(14,2) NOT NULL,
  `total_to_collect` decimal(14,2) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'active',
  `id_owner` bigint(20) unsigned DEFAULT NULL,
  `created_by_user_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_loans_document_id` (`document_id`),
  KEY `idx_loans_status` (`status`),
  KEY `idx_loans_full_name` (`full_name`),
  KEY `idx_loans_created_by` (`created_by_user_id`),
  KEY `idx_loans_owner` (`id_owner`),
  CONSTRAINT `fk_loans_users_created_by` FOREIGN KEY (`created_by_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_loans_users_owner` FOREIGN KEY (`id_owner`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loans`
--

LOCK TABLES `loans` WRITE;
/*!40000 ALTER TABLE `loans` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `loans` VALUES
(5,'Prueba','12345678',10000.00,'mensual',5,3.5000,350.00,10350.00,1750.00,11750.00,'2026-03-21','2026-08-21','active',NULL,NULL,'2026-03-22 01:32:51','2026-03-22 01:32:51'),
(6,'Yeiber','11922250',77000.00,'mensual',5,7.0000,5390.00,82390.00,26950.00,103950.00,'2026-03-23','2026-08-23','active',NULL,NULL,'2026-03-23 12:08:17','2026-03-23 12:08:17'),
(7,'Raul','11922250',10000.00,'mensual',9,5.0000,500.00,10500.00,4500.00,14500.00,'2026-04-01','2027-01-01','active',NULL,NULL,'2026-03-23 16:24:44','2026-03-23 20:19:19'),
(8,'prueba scroll','123456789',1000.00,'mensual',5,10.0000,100.00,1100.00,500.00,1500.00,'2026-03-23','2026-08-23','active',NULL,NULL,'2026-03-23 20:13:11','2026-03-23 20:13:11'),
(9,'prueba scroll 2','1234567489',5000.00,'mensual',3,10.0000,500.00,5500.00,1500.00,6500.00,'2026-03-23','2026-06-23','active',NULL,NULL,'2026-03-23 20:13:25','2026-03-23 20:13:25'),
(10,'prueba 3','123456',1000.00,'mensual',3,2.0000,20.00,1020.00,60.00,1060.00,'2026-03-23','2026-06-23','active',NULL,NULL,'2026-03-23 20:17:54','2026-03-23 20:17:54'),
(11,'kkjhkhkhkj','kjhkkjhkhk',10000.00,'mensual',3,10.0000,1000.00,11000.00,3000.00,13000.00,'2026-03-23','2026-06-23','completed',NULL,NULL,'2026-03-23 21:01:32','2026-03-23 21:01:52');
/*!40000 ALTER TABLE `loans` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `mensajes`
--

DROP TABLE IF EXISTS `mensajes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `mensajes` (
  `id_msm` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `sender` bigint(20) unsigned NOT NULL,
  `full` tinyint(1) NOT NULL DEFAULT 0,
  `agentes` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`agentes`)),
  `prioridad` varchar(20) NOT NULL,
  `titulo` varchar(220) NOT NULL,
  `mensaje` text NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_msm`),
  KEY `idx_mensajes_sender` (`sender`),
  KEY `idx_mensajes_prioridad` (`prioridad`),
  CONSTRAINT `fk_mensajes_users_sender` FOREIGN KEY (`sender`) REFERENCES `users` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mensajes`
--

LOCK TABLES `mensajes` WRITE;
/*!40000 ALTER TABLE `mensajes` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `mensajes` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
(4,'App\\Models\\User',4,'frontend','30b3451cf50c103a5292292cd0933a4b1a98fdb2636d966e5dc12e4cd7c7fd92','[\"*\"]',NULL,NULL,'2026-03-18 00:55:22','2026-03-18 00:55:22'),
(5,'App\\Models\\User',4,'frontend','1b93be232d75b8715de8c24cc5fd21f57a20dbe438104fa7826802658c4cf0a6','[\"*\"]','2026-03-19 00:20:22',NULL,'2026-03-19 00:17:22','2026-03-19 00:20:22'),
(6,'App\\Models\\User',6,'frontend','54e0c13824034a78e2998f278d2344ccf75f20281429c1e6923ad8ce0507089d','[\"*\"]','2026-03-19 01:00:17',NULL,'2026-03-19 00:21:34','2026-03-19 01:00:17'),
(7,'App\\Models\\User',4,'frontend','953469b29a7943ea5b0b34df9483f8b0e15f607af8b64ff3ba50747c078ef71f','[\"*\"]','2026-03-19 00:42:28',NULL,'2026-03-19 00:41:57','2026-03-19 00:42:28'),
(8,'App\\Models\\User',6,'frontend','3732f7efab05a1a9cdfd72812b6204ab168d98e4bcc444beec4d9d479b566915','[\"*\"]','2026-03-19 00:45:50',NULL,'2026-03-19 00:43:35','2026-03-19 00:45:50'),
(9,'App\\Models\\User',6,'frontend','e4c26b7628ef97d70d800495999e42522e42426d80dbc2d269631b22afe734e5','[\"*\"]','2026-03-19 00:53:25',NULL,'2026-03-19 00:46:52','2026-03-19 00:53:25'),
(10,'App\\Models\\User',4,'frontend','c68b2c4fc3c5c16725328e8b34394ebfa4eab6c705f07dacd0106d8f06b55d9e','[\"*\"]','2026-03-19 01:06:58',NULL,'2026-03-19 00:54:47','2026-03-19 01:06:58'),
(11,'App\\Models\\User',4,'frontend','ddffecc5b25d7eb419e0c173679af9148dc13ed8c157041fa79f472d7d5c4a49','[\"*\"]','2026-03-19 01:32:23',NULL,'2026-03-19 01:02:20','2026-03-19 01:32:23'),
(12,'App\\Models\\User',6,'frontend','ad2aed99e6ef492650d6f643fe54effb77c86e11af42c950d6a40a7d9083f09d','[\"*\"]','2026-03-19 01:08:38',NULL,'2026-03-19 01:08:36','2026-03-19 01:08:38'),
(13,'App\\Models\\User',4,'frontend','588b8860f2c517175291a3cd9d8fcec84c21203d934313b9416e14d83f431ee6','[\"*\"]','2026-03-19 01:11:36',NULL,'2026-03-19 01:08:58','2026-03-19 01:11:36'),
(14,'App\\Models\\User',6,'frontend','519a162453079940c0c84301c98d9c9cac90a3fbf26086f7f7aab810c0db3c35','[\"*\"]','2026-03-19 01:11:49',NULL,'2026-03-19 01:11:47','2026-03-19 01:11:49'),
(15,'App\\Models\\User',7,'frontend','dc0a0735c356058d93a99176ee1cded403d63071534c38d1b59daddf3c57898a','[\"*\"]','2026-03-19 01:19:54',NULL,'2026-03-19 01:19:52','2026-03-19 01:19:54'),
(16,'App\\Models\\User',7,'frontend','c6fc91bb6b542ff53a681a48ad97854a447858c22dae0b13f077ecbfe2617fe0','[\"*\"]','2026-03-19 01:20:20',NULL,'2026-03-19 01:20:19','2026-03-19 01:20:20'),
(17,'App\\Models\\User',6,'frontend','6e240c116af8d8a7f64d53d99040555dc33ae50e338463969d20cf6595d3c0ed','[\"*\"]','2026-03-19 01:20:49',NULL,'2026-03-19 01:20:48','2026-03-19 01:20:49'),
(18,'App\\Models\\User',6,'frontend','3c773cea7362c1ca088e449045c085100d822a6018bec47fc4a7944d0e4aa1e5','[\"*\"]','2026-03-19 01:24:10',NULL,'2026-03-19 01:21:49','2026-03-19 01:24:10'),
(19,'App\\Models\\User',4,'frontend','41c082c1e0748876f4af03ed4673c6d78e1f9158e7d98d97c02e79e3d340faca','[\"*\"]','2026-03-19 01:25:41',NULL,'2026-03-19 01:25:39','2026-03-19 01:25:41'),
(20,'App\\Models\\User',4,'frontend','04f603ce4bf0018f442bb3a826c4a29118bfba88d95b4c241218e6bf90cbc595','[\"*\"]','2026-03-19 01:33:02',NULL,'2026-03-19 01:33:00','2026-03-19 01:33:02'),
(21,'App\\Models\\User',4,'frontend','fdb2ea6bbbcf01991898ab085999ba3b6bfd4ec89c98639e09492bfd5e13eee8','[\"*\"]','2026-03-19 01:33:05',NULL,'2026-03-19 01:33:01','2026-03-19 01:33:05'),
(22,'App\\Models\\User',4,'frontend','723fc8748d957f79096db5a68d792a29a6ea2a5b3d8fdcdaf4ad86d038e2711b','[\"*\"]','2026-03-19 11:04:16',NULL,'2026-03-19 04:56:00','2026-03-19 11:04:16'),
(23,'App\\Models\\User',4,'frontend','88912ba16fb371a615fc72f1e730e0ac300f6cd851504204eb3c0cff6b49168e','[\"*\"]','2026-03-19 05:11:44',NULL,'2026-03-19 04:59:00','2026-03-19 05:11:44'),
(24,'App\\Models\\User',4,'frontend','5849a01aa1cf55a4ea8d82eb11e524943c931008632c6f0d0c32b471150fc830','[\"*\"]','2026-03-19 05:16:46',NULL,'2026-03-19 05:13:49','2026-03-19 05:16:46'),
(25,'App\\Models\\User',6,'frontend','9106ba967b909652e8c88e186178168e4bd18a184316c65dd1500e97246d2a6f','[\"*\"]','2026-03-19 05:18:02',NULL,'2026-03-19 05:17:10','2026-03-19 05:18:02'),
(26,'App\\Models\\User',4,'frontend','8a673def40236d4b6bfa379c4ff122117ddbb505a395657504724155529e8172','[\"*\"]','2026-03-19 05:30:50',NULL,'2026-03-19 05:18:42','2026-03-19 05:30:50'),
(27,'App\\Models\\User',4,'frontend','1e88cd4e186a06a4e957d5a760f66a1ab52abb956773040cc77567fb5a6ad472','[\"*\"]','2026-03-19 06:51:37',NULL,'2026-03-19 05:41:27','2026-03-19 06:51:37'),
(28,'App\\Models\\User',6,'frontend','26a552c75574fdfc9522d21edfde282c16a2baf9e5430ac46e04266646802c16','[\"*\"]','2026-03-19 06:53:06',NULL,'2026-03-19 06:51:51','2026-03-19 06:53:06'),
(29,'App\\Models\\User',10,'frontend','9bad62f5cb7cecf35779930e7fd16be7db32eee968dcb50957d037b7ed5fef77','[\"*\"]','2026-03-19 12:02:38',NULL,'2026-03-19 11:07:25','2026-03-19 12:02:38'),
(30,'App\\Models\\User',11,'frontend','dac8454e8e0639840fba94cc925e82a6deb72230734202881040bcf86ea66517','[\"*\"]','2026-03-19 11:19:15',NULL,'2026-03-19 11:10:05','2026-03-19 11:19:15'),
(31,'App\\Models\\User',12,'frontend','9e15bfeb574b20efb2e07872a9e64e8ed1a0f080b9c8e1167cc3946e1fb4456b','[\"*\"]','2026-03-19 14:37:01',NULL,'2026-03-19 11:11:33','2026-03-19 14:37:01'),
(32,'App\\Models\\User',11,'frontend','f3ebeaccda47bcf62c780d5809fc5253ee71e21bb4a70430df30904450d24f41','[\"*\"]','2026-03-19 14:35:44',NULL,'2026-03-19 11:27:39','2026-03-19 14:35:44'),
(33,'App\\Models\\User',10,'frontend','2eeffd63cbacfef81c5813724dd10901934a0331baf47df536ca5b65001170c7','[\"*\"]','2026-03-19 12:26:58',NULL,'2026-03-19 12:03:05','2026-03-19 12:26:58'),
(34,'App\\Models\\User',14,'frontend','a0702c6c9bc004ef27800959b1248b8767d30c741ea3c0dff0ee3a925b55c598','[\"*\"]','2026-03-19 12:34:12',NULL,'2026-03-19 12:28:33','2026-03-19 12:34:12'),
(35,'App\\Models\\User',10,'frontend','9190b06cf5a44f78eaae094facdae0e2d5caaae69a061eae8c0c112b80a794de','[\"*\"]','2026-03-19 14:34:35',NULL,'2026-03-19 12:48:56','2026-03-19 14:34:35'),
(36,'App\\Models\\User',6,'frontend','7c085eb20ed43abc18d433632e4fd60eb624991fac565ee72f5f2dc8976fbcb8','[\"*\"]','2026-03-23 11:27:52',NULL,'2026-03-23 11:14:33','2026-03-23 11:27:52'),
(37,'App\\Models\\User',4,'frontend','93b468716735f8eb9a889180ad76c2b54f2c9c9f8ff7d4e76523be17c0426f39','[\"*\"]','2026-03-23 11:28:05',NULL,'2026-03-23 11:24:57','2026-03-23 11:28:05');
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
(1,'PUB-0001','Residencias El Bosque','Residencias El Bosque','Valencia, Carabobo','Apartamento',125000.00,'disponible','publicado','Apartamento en excelente zona, cerca de centros comerciales.','{\"dormitorios\":3,\"banos\":2,\"area_m2\":110,\"estacionamientos\":2,\"con_piscina\":true,\"pet_friendly\":true,\"ano_construccion\":2018,\"amoblada\":false,\"balcon\":true,\"seguridad_privada\":true,\"financiable\":true}',11,6,10.1620000,-68.0077000,'https://mi-cdn.com/propiedades/p-1-main.jpg','[\"https://mi-cdn.com/propiedades/p-1-2.jpg\",\"https://mi-cdn.com/propiedades/p-1-3.jpg\"]'),
(2,'PUB-0002','Casa Los Naranjos','Casa Los Naranjos','Caracas, Distrito Capital','Casa',185000.00,'disponible','publicado','Casa de dos niveles, remodelada, con buena ventilacion.','{\"dormitorios\":4,\"banos\":3,\"area_m2\":220,\"estacionamientos\":2,\"con_piscina\":false,\"pet_friendly\":true,\"ano_construccion\":2012,\"amoblada\":false,\"balcon\":true,\"seguridad_privada\":true,\"financiable\":true}',11,7,10.4806000,-66.9036000,'https://mi-cdn.com/propiedades/p-2-main.jpg','[\"https://mi-cdn.com/propiedades/p-2-2.jpg\",\"https://mi-cdn.com/propiedades/p-2-3.jpg\"]');
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
  `ref` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_publicar_ciudad_zona` (`ciudad`,`zona`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publicar_ins`
--

LOCK TABLES `publicar_ins` WRITE;
/*!40000 ALTER TABLE `publicar_ins` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `publicar_ins` VALUES
(1,'Yonnel','04129168395','Maracay','Casa','Casa','publicar-in/KDonuP1KOoOSeHHO2qy2EuOt7Xmc6oJ8ujmaR5fW.jpg','Casa',0);
/*!40000 ALTER TABLE `publicar_ins` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `push_configs`
--

DROP TABLE IF EXISTS `push_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `push_configs` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `paused` tinyint(1) NOT NULL DEFAULT 0,
  `pause_until` datetime DEFAULT NULL,
  `pre_due_days` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`pre_due_days`)),
  `pre_due_hour` tinyint(3) unsigned NOT NULL DEFAULT 9,
  `due_morning_start_hour` tinyint(3) unsigned NOT NULL DEFAULT 7,
  `due_morning_end_hour` tinyint(3) unsigned NOT NULL DEFAULT 11,
  `due_afternoon_start_hour` tinyint(3) unsigned NOT NULL DEFAULT 14,
  `due_afternoon_end_hour` tinyint(3) unsigned NOT NULL DEFAULT 18,
  `spread_seconds` int(10) unsigned NOT NULL DEFAULT 20,
  `dispatch_batch_size` int(10) unsigned NOT NULL DEFAULT 100,
  `retry_delay_minutes` int(10) unsigned NOT NULL DEFAULT 5,
  `max_attempts` int(10) unsigned NOT NULL DEFAULT 3,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `push_configs`
--

LOCK TABLES `push_configs` WRITE;
/*!40000 ALTER TABLE `push_configs` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `push_configs` VALUES
(1,1,0,NULL,'[1,2,3]',9,0,23,0,23,20,100,5,3,'2026-03-22 00:21:37','2026-03-22 01:39:18');
/*!40000 ALTER TABLE `push_configs` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `push_notifications`
--

DROP TABLE IF EXISTS `push_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `push_notifications` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `loan_id` bigint(20) DEFAULT NULL,
  `loan_cut_id` bigint(20) DEFAULT NULL,
  `event_type` varchar(60) NOT NULL,
  `event_date` date NOT NULL,
  `event_hour` tinyint(3) unsigned DEFAULT NULL,
  `dedupe_key` varchar(191) NOT NULL,
  `title` varchar(180) NOT NULL,
  `body` text NOT NULL,
  `url` varchar(2000) DEFAULT NULL,
  `tag` varchar(120) DEFAULT NULL,
  `scheduled_at` datetime NOT NULL,
  `status` enum('pending','sent','failed') NOT NULL DEFAULT 'pending',
  `attempts` int(10) unsigned NOT NULL DEFAULT 0,
  `recipients` int(10) unsigned NOT NULL DEFAULT 0,
  `success_count` int(10) unsigned NOT NULL DEFAULT 0,
  `failed_count` int(10) unsigned NOT NULL DEFAULT 0,
  `sent_at` datetime DEFAULT NULL,
  `last_error` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_push_notifications_dedupe` (`dedupe_key`),
  KEY `idx_push_notifications_status_scheduled` (`status`,`scheduled_at`),
  KEY `idx_push_notifications_created` (`created_at`),
  KEY `idx_push_notifications_loan_cut` (`loan_cut_id`),
  KEY `idx_push_notifications_loan` (`loan_id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `push_notifications`
--

LOCK TABLES `push_notifications` WRITE;
/*!40000 ALTER TABLE `push_notifications` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `push_notifications` VALUES
(4,5,18,'due_hourly','2026-03-21',9,'cut:18:due_hourly:2026-03-21:09','Corte con vencimiento hoy','Prueba: hoy vence tu corte de 350.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=5&cutId=18','loan-due-today-cut-18-h09','2026-03-21 09:00:00','sent',1,2,2,0,'2026-03-21 09:10:00',NULL,'2026-03-21 21:58:56','2026-03-21 21:58:56'),
(5,5,18,'due_hourly','2026-03-21',22,'cut:18:due_hourly:2026-03-21:22','Corte con vencimiento hoy','Prueba: hoy vence tu corte de 350.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=5&cutId=18','loan-due-today-cut-18-h22','2026-03-21 22:00:00','sent',1,2,2,0,'2026-03-21 22:00:01',NULL,'2026-03-21 22:00:01','2026-03-21 22:00:01'),
(6,5,18,'due_hourly','2026-03-21',23,'cut:18:due_hourly:2026-03-21:23','Corte con vencimiento hoy','Prueba: hoy vence tu corte de 350.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=5&cutId=18','loan-due-today-cut-18-h23','2026-03-21 23:00:00','sent',1,2,2,0,'2026-03-21 23:00:01',NULL,'2026-03-21 23:00:01','2026-03-21 23:00:02'),
(7,5,19,'due_hourly','2026-03-22',0,'cut:19:due_hourly:2026-03-22:00','Corte con vencimiento hoy','Prueba: hoy vence tu corte de 350.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=5&cutId=19','loan-due-today-cut-19-h00','2026-03-22 00:00:00','sent',1,2,2,0,'2026-03-22 00:00:01',NULL,'2026-03-22 00:00:01','2026-03-22 00:00:01'),
(8,5,19,'due_hourly','2026-03-22',1,'cut:19:due_hourly:2026-03-22:01','Corte con vencimiento hoy','Prueba: hoy vence tu corte de 350.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=5&cutId=19','loan-due-today-cut-19-h01','2026-03-22 01:00:00','sent',1,2,2,0,'2026-03-22 01:00:01',NULL,'2026-03-22 01:00:01','2026-03-22 01:00:01'),
(9,5,19,'due_hourly','2026-03-22',2,'cut:19:due_hourly:2026-03-22:02','Corte con vencimiento hoy','Prueba: hoy vence tu corte de 350.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=5&cutId=19','loan-due-today-cut-19-h02','2026-03-22 02:00:00','sent',1,2,2,0,'2026-03-22 02:00:01',NULL,'2026-03-22 02:00:01','2026-03-22 02:00:02'),
(10,5,19,'due_hourly','2026-03-22',3,'cut:19:due_hourly:2026-03-22:03','Corte con vencimiento hoy','Prueba: hoy vence tu corte de 350.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=5&cutId=19','loan-due-today-cut-19-h03','2026-03-22 03:00:00','sent',1,2,2,0,'2026-03-22 03:00:02',NULL,'2026-03-22 03:00:02','2026-03-22 03:00:02'),
(11,5,19,'due_hourly','2026-03-22',4,'cut:19:due_hourly:2026-03-22:04','Corte con vencimiento hoy','Prueba: hoy vence tu corte de 350.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=5&cutId=19','loan-due-today-cut-19-h04','2026-03-22 04:00:00','sent',1,2,2,0,'2026-03-22 04:00:02',NULL,'2026-03-22 04:00:02','2026-03-22 04:00:02'),
(12,5,19,'due_hourly','2026-03-22',5,'cut:19:due_hourly:2026-03-22:05','Corte con vencimiento hoy','Prueba: hoy vence tu corte de 350.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=5&cutId=19','loan-due-today-cut-19-h05','2026-03-22 05:00:00','sent',1,2,2,0,'2026-03-22 05:00:01',NULL,'2026-03-22 05:00:01','2026-03-22 05:00:01'),
(13,5,19,'due_hourly','2026-03-22',6,'cut:19:due_hourly:2026-03-22:06','Corte con vencimiento hoy','Prueba: hoy vence tu corte de 350.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=5&cutId=19','loan-due-today-cut-19-h06','2026-03-22 06:00:00','sent',1,2,2,0,'2026-03-22 06:00:01',NULL,'2026-03-22 06:00:01','2026-03-22 06:00:02'),
(14,5,19,'due_hourly','2026-03-22',7,'cut:19:due_hourly:2026-03-22:07','Corte con vencimiento hoy','Prueba: hoy vence tu corte de 350.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=5&cutId=19','loan-due-today-cut-19-h07','2026-03-22 07:00:00','sent',1,2,2,0,'2026-03-22 07:00:01',NULL,'2026-03-22 07:00:01','2026-03-22 07:00:01'),
(15,5,19,'due_hourly','2026-03-22',8,'cut:19:due_hourly:2026-03-22:08','Corte con vencimiento hoy','Prueba: hoy vence tu corte de 350.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=5&cutId=19','loan-due-today-cut-19-h08','2026-03-22 08:00:00','sent',1,2,2,0,'2026-03-22 08:00:01',NULL,'2026-03-22 08:00:01','2026-03-22 08:00:01'),
(16,5,19,'due_hourly','2026-03-22',9,'cut:19:due_hourly:2026-03-22:09','Corte con vencimiento hoy','Prueba: hoy vence tu corte de 350.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=5&cutId=19','loan-due-today-cut-19-h09','2026-03-22 09:00:00','sent',1,2,2,0,'2026-03-22 09:00:01',NULL,'2026-03-22 09:00:01','2026-03-22 09:00:01'),
(17,5,19,'due_hourly','2026-03-22',10,'cut:19:due_hourly:2026-03-22:10','Corte con vencimiento hoy','Prueba: hoy vence tu corte de 350.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=5&cutId=19','loan-due-today-cut-19-h10','2026-03-22 10:00:00','sent',1,2,2,0,'2026-03-22 10:00:01',NULL,'2026-03-22 10:00:01','2026-03-22 10:00:02'),
(18,5,19,'due_hourly','2026-03-22',11,'cut:19:due_hourly:2026-03-22:11','Corte con vencimiento hoy','Prueba: hoy vence tu corte de 350.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=5&cutId=19','loan-due-today-cut-19-h11','2026-03-22 11:00:00','sent',1,2,2,0,'2026-03-22 11:00:02',NULL,'2026-03-22 11:00:01','2026-03-22 11:00:02'),
(19,5,19,'due_hourly','2026-03-22',12,'cut:19:due_hourly:2026-03-22:12','Corte con vencimiento hoy','Prueba: hoy vence tu corte de 350.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=5&cutId=19','loan-due-today-cut-19-h12','2026-03-22 12:00:00','sent',1,2,2,0,'2026-03-22 12:00:01',NULL,'2026-03-22 12:00:01','2026-03-22 12:00:01'),
(20,5,19,'due_hourly','2026-03-22',13,'cut:19:due_hourly:2026-03-22:13','Corte con vencimiento hoy','Prueba: hoy vence tu corte de 350.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=5&cutId=19','loan-due-today-cut-19-h13','2026-03-22 13:00:00','sent',1,2,2,0,'2026-03-22 13:00:02',NULL,'2026-03-22 13:00:02','2026-03-22 13:00:02'),
(21,5,19,'due_hourly','2026-03-22',14,'cut:19:due_hourly:2026-03-22:14','Corte con vencimiento hoy','Prueba: hoy vence tu corte de 350.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=5&cutId=19','loan-due-today-cut-19-h14','2026-03-22 14:00:00','sent',1,2,2,0,'2026-03-22 14:00:02',NULL,'2026-03-22 14:00:02','2026-03-22 14:00:02'),
(22,5,19,'due_hourly','2026-03-22',15,'cut:19:due_hourly:2026-03-22:15','Corte con vencimiento hoy','Prueba: hoy vence tu corte de 350.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=5&cutId=19','loan-due-today-cut-19-h15','2026-03-22 15:00:00','sent',1,2,2,0,'2026-03-22 15:00:01',NULL,'2026-03-22 15:00:01','2026-03-22 15:00:02'),
(23,5,19,'due_hourly','2026-03-22',16,'cut:19:due_hourly:2026-03-22:16','Corte con vencimiento hoy','Prueba: hoy vence tu corte de 350.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=5&cutId=19','loan-due-today-cut-19-h16','2026-03-22 16:00:00','sent',1,2,2,0,'2026-03-22 16:00:02',NULL,'2026-03-22 16:00:01','2026-03-22 16:00:02'),
(24,5,19,'due_hourly','2026-03-22',17,'cut:19:due_hourly:2026-03-22:17','Corte con vencimiento hoy','Prueba: hoy vence tu corte de 350.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=5&cutId=19','loan-due-today-cut-19-h17','2026-03-22 17:00:00','sent',1,2,2,0,'2026-03-22 17:00:02',NULL,'2026-03-22 17:00:02','2026-03-22 17:00:02'),
(25,5,19,'due_hourly','2026-03-22',18,'cut:19:due_hourly:2026-03-22:18','Corte con vencimiento hoy','Prueba: hoy vence tu corte de 350.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=5&cutId=19','loan-due-today-cut-19-h18','2026-03-22 18:00:00','sent',1,2,2,0,'2026-03-22 18:00:02',NULL,'2026-03-22 18:00:02','2026-03-22 18:00:02'),
(26,5,19,'due_hourly','2026-03-22',19,'cut:19:due_hourly:2026-03-22:19','Corte con vencimiento hoy','Prueba: hoy vence tu corte de 350.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=5&cutId=19','loan-due-today-cut-19-h19','2026-03-22 19:00:00','sent',1,2,2,0,'2026-03-22 19:00:02',NULL,'2026-03-22 19:00:02','2026-03-22 19:00:02'),
(27,5,19,'due_hourly','2026-03-22',20,'cut:19:due_hourly:2026-03-22:20','Corte con vencimiento hoy','Prueba: hoy vence tu corte de 350.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=5&cutId=19','loan-due-today-cut-19-h20','2026-03-22 20:00:00','sent',1,2,2,0,'2026-03-22 20:00:02',NULL,'2026-03-22 20:00:02','2026-03-22 20:00:02'),
(28,5,19,'due_hourly','2026-03-22',21,'cut:19:due_hourly:2026-03-22:21','Corte con vencimiento hoy','Prueba: hoy vence tu corte de 350.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=5&cutId=19','loan-due-today-cut-19-h21','2026-03-22 21:00:00','sent',1,2,2,0,'2026-03-22 21:00:01',NULL,'2026-03-22 21:00:01','2026-03-22 21:00:02'),
(29,5,19,'due_hourly','2026-03-22',22,'cut:19:due_hourly:2026-03-22:22','Corte con vencimiento hoy','Prueba: hoy vence tu corte de 350.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=5&cutId=19','loan-due-today-cut-19-h22','2026-03-22 22:00:00','sent',1,2,2,0,'2026-03-22 22:00:01',NULL,'2026-03-22 22:00:01','2026-03-22 22:00:02'),
(30,5,19,'due_hourly','2026-03-22',23,'cut:19:due_hourly:2026-03-22:23','Corte con vencimiento hoy','Prueba: hoy vence tu corte de 350.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=5&cutId=19','loan-due-today-cut-19-h23','2026-03-22 23:00:00','sent',1,2,2,0,'2026-03-22 23:00:02',NULL,'2026-03-22 23:00:02','2026-03-22 23:00:02'),
(31,5,20,'due_hourly','2026-03-23',0,'cut:20:due_hourly:2026-03-23:00','Corte con vencimiento hoy','Prueba: hoy vence tu corte de 350.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=5&cutId=20','loan-due-today-cut-20-h00','2026-03-23 00:00:00','sent',1,2,2,0,'2026-03-23 00:00:01',NULL,'2026-03-23 00:00:01','2026-03-23 00:00:02'),
(32,5,20,'due_hourly','2026-03-23',1,'cut:20:due_hourly:2026-03-23:01','Corte con vencimiento hoy','Prueba: hoy vence tu corte de 350.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=5&cutId=20','loan-due-today-cut-20-h01','2026-03-23 01:00:00','sent',1,2,2,0,'2026-03-23 01:00:02',NULL,'2026-03-23 01:00:02','2026-03-23 01:00:02'),
(33,5,20,'due_hourly','2026-03-23',2,'cut:20:due_hourly:2026-03-23:02','Corte con vencimiento hoy','Prueba: hoy vence tu corte de 350.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=5&cutId=20','loan-due-today-cut-20-h02','2026-03-23 02:00:00','sent',1,2,2,0,'2026-03-23 02:00:01',NULL,'2026-03-23 02:00:01','2026-03-23 02:00:01'),
(34,5,20,'due_hourly','2026-03-23',3,'cut:20:due_hourly:2026-03-23:03','Corte con vencimiento hoy','Prueba: hoy vence tu corte de 350.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=5&cutId=20','loan-due-today-cut-20-h03','2026-03-23 03:00:00','sent',1,2,2,0,'2026-03-23 03:00:01',NULL,'2026-03-23 03:00:01','2026-03-23 03:00:01'),
(35,5,20,'due_hourly','2026-03-23',4,'cut:20:due_hourly:2026-03-23:04','Corte con vencimiento hoy','Prueba: hoy vence tu corte de 350.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=5&cutId=20','loan-due-today-cut-20-h04','2026-03-23 04:00:00','sent',1,2,2,0,'2026-03-23 04:00:01',NULL,'2026-03-23 04:00:01','2026-03-23 04:00:02'),
(36,5,20,'due_hourly','2026-03-23',5,'cut:20:due_hourly:2026-03-23:05','Corte con vencimiento hoy','Prueba: hoy vence tu corte de 350.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=5&cutId=20','loan-due-today-cut-20-h05','2026-03-23 05:00:00','sent',1,2,2,0,'2026-03-23 05:00:01',NULL,'2026-03-23 05:00:01','2026-03-23 05:00:02'),
(37,5,20,'due_hourly','2026-03-23',6,'cut:20:due_hourly:2026-03-23:06','Corte con vencimiento hoy','Prueba: hoy vence tu corte de 350.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=5&cutId=20','loan-due-today-cut-20-h06','2026-03-23 06:00:00','sent',1,2,2,0,'2026-03-23 06:00:02',NULL,'2026-03-23 06:00:02','2026-03-23 06:00:02'),
(38,5,20,'due_hourly','2026-03-23',7,'cut:20:due_hourly:2026-03-23:07','Corte con vencimiento hoy','Prueba: hoy vence tu corte de 350.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=5&cutId=20','loan-due-today-cut-20-h07','2026-03-23 07:00:00','sent',1,2,2,0,'2026-03-23 07:00:01',NULL,'2026-03-23 07:00:01','2026-03-23 07:00:01'),
(39,5,20,'due_hourly','2026-03-23',8,'cut:20:due_hourly:2026-03-23:08','Corte con vencimiento hoy','Prueba: hoy vence tu corte de 350.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=5&cutId=20','loan-due-today-cut-20-h08','2026-03-23 08:00:00','sent',1,2,2,0,'2026-03-23 08:00:02',NULL,'2026-03-23 08:00:02','2026-03-23 08:00:02'),
(40,5,20,'due_hourly','2026-03-23',9,'cut:20:due_hourly:2026-03-23:09','Corte con vencimiento hoy','Prueba: hoy vence tu corte de 350.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=5&cutId=20','loan-due-today-cut-20-h09','2026-03-23 09:00:00','sent',1,2,2,0,'2026-03-23 09:00:01',NULL,'2026-03-23 09:00:01','2026-03-23 09:00:01'),
(41,5,20,'due_hourly','2026-03-23',10,'cut:20:due_hourly:2026-03-23:10','Corte con vencimiento hoy','Prueba: hoy vence tu corte de 350.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=5&cutId=20','loan-due-today-cut-20-h10','2026-03-23 10:00:00','sent',1,2,2,0,'2026-03-23 10:00:02',NULL,'2026-03-23 10:00:02','2026-03-23 10:00:02'),
(42,5,20,'due_hourly','2026-03-23',11,'cut:20:due_hourly:2026-03-23:11','Corte con vencimiento hoy','Prueba: hoy vence tu corte de 350.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=5&cutId=20','loan-due-today-cut-20-h11','2026-03-23 11:00:00','sent',1,2,2,0,'2026-03-23 11:00:01',NULL,'2026-03-23 11:00:01','2026-03-23 11:00:02'),
(43,5,20,'due_hourly','2026-03-23',12,'cut:20:due_hourly:2026-03-23:12','Corte con vencimiento hoy','Prueba: hoy vence tu corte de 350.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=5&cutId=20','loan-due-today-cut-20-h12','2026-03-23 12:00:00','sent',1,2,2,0,'2026-03-23 12:00:01',NULL,'2026-03-23 12:00:01','2026-03-23 12:00:02'),
(44,5,20,'due_hourly','2026-03-23',13,'cut:20:due_hourly:2026-03-23:13','Corte con vencimiento hoy','Prueba: hoy vence tu corte de 350.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=5&cutId=20','loan-due-today-cut-20-h13','2026-03-23 13:00:00','sent',1,2,2,0,'2026-03-23 13:00:01',NULL,'2026-03-23 13:00:01','2026-03-23 13:00:01'),
(45,5,20,'due_hourly','2026-03-23',14,'cut:20:due_hourly:2026-03-23:14','Corte con vencimiento hoy','Prueba: hoy vence tu corte de 350.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=5&cutId=20','loan-due-today-cut-20-h14','2026-03-23 14:00:00','sent',1,2,2,0,'2026-03-23 14:00:02',NULL,'2026-03-23 14:00:02','2026-03-23 14:00:02'),
(46,5,20,'due_hourly','2026-03-23',15,'cut:20:due_hourly:2026-03-23:15','Corte con vencimiento hoy','Prueba: hoy vence tu corte de 350.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=5&cutId=20','loan-due-today-cut-20-h15','2026-03-23 15:00:00','sent',1,2,2,0,'2026-03-23 15:00:02',NULL,'2026-03-23 15:00:02','2026-03-23 15:00:02'),
(47,5,20,'due_hourly','2026-03-23',16,'cut:20:due_hourly:2026-03-23:16','Corte con vencimiento hoy','Prueba: hoy vence tu corte de 350.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=5&cutId=20','loan-due-today-cut-20-h16','2026-03-23 16:00:00','sent',1,2,2,0,'2026-03-23 16:00:01',NULL,'2026-03-23 16:00:01','2026-03-23 16:00:02'),
(48,5,20,'due_hourly','2026-03-23',17,'cut:20:due_hourly:2026-03-23:17','Corte con vencimiento hoy','Prueba: hoy vence tu corte de 350.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=5&cutId=20','loan-due-today-cut-20-h17','2026-03-23 17:00:00','sent',1,2,2,0,'2026-03-23 17:00:01',NULL,'2026-03-23 17:00:01','2026-03-23 17:00:02'),
(49,5,20,'due_hourly','2026-03-23',18,'cut:20:due_hourly:2026-03-23:18','Corte con vencimiento hoy','Prueba: hoy vence tu corte de 350.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=5&cutId=20','loan-due-today-cut-20-h18','2026-03-23 18:00:00','sent',1,2,2,0,'2026-03-23 18:00:01',NULL,'2026-03-23 18:00:01','2026-03-23 18:00:01'),
(50,5,20,'due_hourly','2026-03-23',19,'cut:20:due_hourly:2026-03-23:19','Corte con vencimiento hoy','Prueba: hoy vence tu corte de 350.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=5&cutId=20','loan-due-today-cut-20-h19','2026-03-23 19:00:00','sent',1,2,2,0,'2026-03-23 19:00:01',NULL,'2026-03-23 19:00:01','2026-03-23 19:00:02'),
(51,5,20,'due_hourly','2026-03-23',20,'cut:20:due_hourly:2026-03-23:20','Corte con vencimiento hoy','Prueba: hoy vence tu corte de 350.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=5&cutId=20','loan-due-today-cut-20-h20','2026-03-23 20:00:00','sent',1,2,2,0,'2026-03-23 20:00:02',NULL,'2026-03-23 20:00:01','2026-03-23 20:00:02'),
(52,5,20,'due_hourly','2026-03-23',21,'cut:20:due_hourly:2026-03-23:21','Corte con vencimiento hoy','Prueba: hoy vence tu corte de 350.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=5&cutId=20','loan-due-today-cut-20-h21','2026-03-23 21:00:00','sent',1,3,3,0,'2026-03-23 21:00:01',NULL,'2026-03-23 21:00:01','2026-03-23 21:00:01');
/*!40000 ALTER TABLE `push_notifications` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `push_subscriptions`
--

DROP TABLE IF EXISTS `push_subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `push_subscriptions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `device_id` varchar(120) NOT NULL,
  `endpoint` varchar(700) NOT NULL,
  `p256dh` text NOT NULL,
  `auth` text NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_push_endpoint` (`endpoint`),
  KEY `idx_push_device_id` (`device_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `push_subscriptions`
--

LOCK TABLES `push_subscriptions` WRITE;
/*!40000 ALTER TABLE `push_subscriptions` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `push_subscriptions` VALUES
(6,'99f62037-0886-4789-aed1-b0b13599f394','https://fcm.googleapis.com/fcm/send/cYjl27Z3604:APA91bH5u9aUfTv6IY8ettGokmuem3dbI2roetFikd_hirtI1cPwDySEsayPUAhJG_fAa9W_3AOqcaEYBDHoKeJieHv_qR0Yg21aBwq9GWG6qKtIzmhlICqMOl17lS7F_CiweppdvSuK','BEFfCc66y1Ok9Q2Gv9j0oED5ypI4AjbUrjlxKrUWPaqv-26ydZ2Y8gaXkbnJSkIyNx3vX0pcRah7MxJ288g_YaI','HfRvXfujuFsTJnfjowbd-g','2026-03-22 00:17:42','2026-03-22 00:17:42'),
(7,'a33af6b8-5c44-4b39-ba7b-c1541987addc','https://fcm.googleapis.com/fcm/send/cyCQA62vCQI:APA91bGXCW7_9Pgyvf0ZKxU1ckShFCVToiJhwxERAhUb0iKiUy-xZlKDRDLGOQTbPZG-5g8iQY_-ygMG0d20BPjza2ZOrMIgdJXRdFe2IILN4K2niN1JjBQaFmDbS0cdcM-UaTXutcwu','BJKrFXHlRv_81FPsFIeKvvCMDsu3tYEgNEBAGrg1jwm7zpfU9IMV5Kc4JKxQvYSmPr1hvD2hY5o_Z_df6MAYkeI','H8oEM75-DdKI96OSJc2eew','2026-03-22 00:18:46','2026-03-22 00:18:46'),
(8,'4b1d5357-d61c-4292-a0f7-f58c788c0614','https://fcm.googleapis.com/fcm/send/c-bM7YhUoh0:APA91bHHTWO7vM81UKWQl7wQtoyMEso51pI9B6c6uc-tTDVohqYDkwzEvfrcilpIs6fUqn7VQ8aja5ceQoGmHABNAg_Z46qEhel6o0-FpOBTX6eybx0yhAajOhscSQwtsQvzcc7UvT5_','BCy41QUm2DWFyDQ2tVRi8nZGMFSGt4t2qOZZlflxnMPLVhheksxziMWUpGpJWPmGjB230aKDv77dFHvvnqrjhqA','MFLwU-3-5bpFZ_Vb9ndEMg','2026-03-23 20:33:11','2026-03-23 20:33:11'),
(9,'4b1d5357-d61c-4292-a0f7-f58c788c0614','https://fcm.googleapis.com/fcm/send/cgDjm3tkUDA:APA91bGk27PwB76HtlqqDV5nDIDwAnAwUJs8Uns6lEVU6lK6_AE-DdXVNeMPNfKH7yJdUqGeGqBj9acfIFsGq2tz-H2lPvbdSOyda5zFNwyp7SRKJ8RgPOpf3e5uxD6DtKg_ASXGes4u','BDvo1X5htr8kfRluTSwI9-3unPJRCqKC0XShm-s4JQ4AqBOI8LcghhI8YMWi70LjKHyZ_KFN0Mw0t8ZSa-Lm-SE','ObIkUwsoj65X7LgUHNHROw','2026-03-23 21:00:14','2026-03-23 21:00:14'),
(10,'4b1d5357-d61c-4292-a0f7-f58c788c0614','https://fcm.googleapis.com/fcm/send/eOpR7N5cwOY:APA91bE7zxvu8o7RiaePix4YRbzshtr7_5YU_lq6Y4jmHUcZ-fwgORTCN7euIXrOXKLYVo0tysOlgWFam-tnvCcUfSB83WFtuxkG2YAEMzMvT0oTTjXCQG6hzTGTkNIkBkYCPe_1W-TU','BB8DsCzhfjI3CD0GNM8yvSmIYg271Xk6X3sHsS090xc_ZsSpNui0gOdTpWRfWk6gTBuil6KlAt8rjrbPMgaKi4U','22QY091-SdGvzcySJnFhtw','2026-03-23 21:00:42','2026-03-23 21:00:42');
/*!40000 ALTER TABLE `push_subscriptions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `reuniones`
--

DROP TABLE IF EXISTS `reuniones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `reuniones` (
  `id_reunion` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `titulo` varchar(200) NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `lugar` varchar(255) NOT NULL,
  `id_cliente` bigint(20) unsigned DEFAULT NULL,
  `notas` text DEFAULT NULL,
  `ref` bigint(20) unsigned DEFAULT NULL,
  `mod` tinyint(1) NOT NULL DEFAULT 0,
  `estado` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`id_reunion`),
  KEY `idx_reuniones_fecha` (`fecha`),
  KEY `idx_reuniones_ref` (`ref`),
  KEY `idx_reuniones_cliente` (`id_cliente`),
  CONSTRAINT `fk_reuniones_clientes` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reuniones`
--

LOCK TABLES `reuniones` WRITE;
/*!40000 ALTER TABLE `reuniones` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `reuniones` VALUES
(1,'Holas','2026-03-20','10:00:00','Yonnel Moises',4,'Completada',5,0,'completada'),
(2,'Holahola','2026-03-24','09:00:00','Hola',4,'Listou',6,0,'completada'),
(3,'prueba sara 1','2026-03-24','02:04:00','mi casa',NULL,'fdfbbdfb',11,1,NULL),
(4,'pepe reu prueba','2026-03-11','09:00:00','dadada',11,'todo ok',12,1,'completada'),
(5,'prueba 3ro sara','2026-03-29','09:00:00','dsddadsa',11,'dadadssdaa',11,0,NULL),
(6,'prueba reunion','2026-03-25','09:00:00','Maracay',4,'todo bien',6,1,'completada');
/*!40000 ALTER TABLE `reuniones` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `rutas`
--

DROP TABLE IF EXISTS `rutas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `rutas` (
  `id_ruta` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ref` bigint(20) unsigned NOT NULL,
  `zona` varchar(180) NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_final` time NOT NULL,
  `sectores` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`sectores`)),
  `ubicacion_inicial` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`ubicacion_inicial`)),
  `recaudos` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`recaudos`)),
  `agentes` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (`agentes` is null or json_valid(`agentes`)),
  `resultados` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (`resultados` is null or json_valid(`resultados`)),
  `notas` text DEFAULT NULL,
  PRIMARY KEY (`id_ruta`),
  KEY `idx_rutas_ref` (`ref`),
  KEY `idx_rutas_zona` (`zona`),
  CONSTRAINT `fk_rutas_users_ref` FOREIGN KEY (`ref`) REFERENCES `users` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rutas`
--

LOCK TABLES `rutas` WRITE;
/*!40000 ALTER TABLE `rutas` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `rutas` VALUES
(1,4,'Test','08:30:00','12:30:00','[\"la arboleda\",\"el valle\",\"cualquier cosa\"]','{\"lat\":10.187529,\"lng\":-64.634298}','[\"volantes entregados\",\"Visitas\",\"Muestras\"]',NULL,'[{\"requisito\":\"volantes entregados\",\"resultado\":\"50\"},{\"requisito\":\"Visitas\",\"resultado\":\"15\"},{\"requisito\":\"Muestras\",\"resultado\":\"10\"}]','todo bien');
/*!40000 ALTER TABLE `rutas` ENABLE KEYS */;
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
('1BBTNVZC4z0DpFoffH9TWqvarTgzjcb4foMQaoc7',NULL,'104.23.166.155','Dalvik/2.1.0 (Linux; U; Android 9.0; ZTE BA520 Build/MRA58K)','YTozOntzOjY6Il90b2tlbiI7czo0MDoiZ2R3NnlVc3M1bzd2YW1PUDBwSjladkZyY3pzbjZYZmladmwxOFlTZCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIdHFmc3VieHJuajZoN1hUIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1774220944),
('5dyCmRRAfW9HaZjINTsxLDYnYv4isbrF08ghgzdt',NULL,'172.69.222.97','curl/8.7.1','YTozOntzOjY6Il90b2tlbiI7czo0MDoiWmY5elVaNFd0OWprWHJlQW82QWdpaGdadTNOWVJNWWZGV1NuTXBxSiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDc6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mby8/cGhwaW5mby5waHA9IjtzOjU6InJvdXRlIjtzOjI3OiJnZW5lcmF0ZWQ6Okh0cWZzdWJ4cm5qNmg3WFQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19',1774302772),
('5tZKb36yu3FtYHMgfLUKInrvPrYrAB4EnDEWFRKN',NULL,'172.70.108.240','Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1','YTozOntzOjY6Il90b2tlbiI7czo0MDoiUjN0MlMzd2lwcmhZRVZnakdlQ2wxc3ppSVlrYUJ6RWxrcFlPTXFtMCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIdHFmc3VieHJuajZoN1hUIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1774305297),
('7fXyjVmbLYajIUkjBMfbYdsbrmSWEk1Da24hWW4F',NULL,'172.69.222.97','curl/8.7.1','YTozOntzOjY6Il90b2tlbiI7czo0MDoidUM1THhCWUVheXhpc3BZaEZKelpoUDYycWlqZDlmOGJIanZLRVdkMiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDQ6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mby8/cGhwaW5mbz0xIjtzOjU6InJvdXRlIjtzOjI3OiJnZW5lcmF0ZWQ6Okh0cWZzdWJ4cm5qNmg3WFQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19',1774302772),
('8cDs53YDzIOtXAmM4l8ja9G0NQv1W3XGBAhedeA4',NULL,'104.23.213.116','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoielp5OGU2SUJRNUw2WUJPRVU4alBibjNFakF4SmlzYnpsckJBUGdncyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIdHFmc3VieHJuajZoN1hUIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1774245369),
('8oZ0knjRfKiCcUStbzeXvVAUiHEoVKRnq5KwGO5h',NULL,'172.69.130.99','req/v3 (https://github.com/imroc/req)','YTozOntzOjY6Il90b2tlbiI7czo0MDoiMjJvU2prdVdpWW9zTUg4MW1FUGtqWnhsYjJCQW9WZ1JQR01iZ2lFTCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIdHFmc3VieHJuajZoN1hUIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1774309024),
('anAA6IAD2TvZ5geQQULBhTVatX7lGIdrPHrXamia',NULL,'172.71.155.10','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1','YTozOntzOjY6Il90b2tlbiI7czo0MDoibjVhQVdIUDYzT1FvdFRuQUdyVzNTTjl1WnVRVWtDcW5Uc1ZTeHNBSyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIdHFmc3VieHJuajZoN1hUIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1774230921),
('APvVy0Vh6bVg4hqbMBx2UjuyH0pt4RPD4awR3xGO',NULL,'172.69.222.97','curl/8.7.1','YTozOntzOjY6Il90b2tlbiI7czo0MDoianNuMlk2dDVZNEJpMDVKdW1jdkV6MDJ4UWVOVzN5SjZING12NGRKaiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDE6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mby8/cT1pbmZvIjtzOjU6InJvdXRlIjtzOjI3OiJnZW5lcmF0ZWQ6Okh0cWZzdWJ4cm5qNmg3WFQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19',1774302772),
('bRoiU3XON15gR0EJjrFKJO4ZXm2mPTptKshYZ2Pr',NULL,'104.23.168.38','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11) AppleWebKit/601.1.27 (KHTML, like Gecko) Chrome/47.0.2526.106 Safari/601.1.27','YTozOntzOjY6Il90b2tlbiI7czo0MDoiMkZJNTB3UllWdUtkUlRITVFxZ1JxUEhKa1ZSMzBWeWcwNE5TR3ZUZSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIdHFmc3VieHJuajZoN1hUIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1774308618),
('ByYi0bsJ87pT9pSCkspAKDpAfSI1px7G5qD73Lqn',NULL,'104.23.221.108','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:123.0) Gecko/20100101 Firefox/123','YTozOntzOjY6Il90b2tlbiI7czo0MDoiTUpoamRER25ZcjJsSUVZTFVKZEp4YTY2YjNoWmJnYk14cWtDTUVQZCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIdHFmc3VieHJuajZoN1hUIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1774228959),
('DardK2pOJLyhZYZpDtZoDYe6csUlwotUw4G0m1sp',NULL,'104.22.20.158','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1','YTozOntzOjY6Il90b2tlbiI7czo0MDoibkEybmpyamRjOXpXZ0pSeGFaSWhMRTUwaVZ1YWhGczEzVXJucXpESyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIdHFmc3VieHJuajZoN1hUIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1774293842),
('E7ZFND5BcflDn5pTzjFm5x2oUXk9y4ivBaDoTQN5',NULL,'172.71.98.88','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/106.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiYzFvQlBFNEpmU3ZZbndyczRRcFFQZ2pFQ1pxSFpzemFvVVA5M0s2YSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIdHFmc3VieHJuajZoN1hUIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1774309016),
('eC7BvOnbYxWSlTNEn4FO7Ivzr2BD9W8uxwrqWJj9',NULL,'172.70.142.77','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.61 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoidUJ3Wm42OGlqQVBmSzBTZ21IRUt5M3VqQUZGeWJ2dlJYVDVlVkFwMiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIdHFmc3VieHJuajZoN1hUIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1774247539),
('F1eml6YySpSl6cva08amsjNLNPXktu6EFUsXKUBo',NULL,'104.23.170.80','Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2','YTozOntzOjY6Il90b2tlbiI7czo0MDoiSW8wTkt5clBXZmI0UmJHSnNKckdwSHM5ejJ1M1ZEQWswT0lWR0dPTSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIdHFmc3VieHJuajZoN1hUIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1774220739),
('gnVPwhvY2Gz397JJ1Zm9U1RwIXowAFzW1yg9U9Sw',NULL,'104.22.23.16','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.61 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoib0hmNTA2aFhkRjJuQ2NtUmlXYlByMEljY1lndTd6cXYzSkE2SlgyQyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIdHFmc3VieHJuajZoN1hUIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1774247540),
('GSHGTo5WvA6Aa37sUnk7zX8zhs8XPpU3NIpgyUc8',NULL,'172.64.215.176','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiUEFVc3dUZmNUbEk5Sm1Ydk9OSzgxZDV4MmU5MjY5eHhUMWx2WVRKeiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIdHFmc3VieHJuajZoN1hUIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1774281287),
('HX69T25DYgPi84gPHdncPh15oUfMxWYu5z32h9if',NULL,'172.70.215.30','Mozilla/5.082584686 Mozilla/5.0 (iPhone; CPU iPhone OS 11_4_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/11.0 Mobile/15E148 Safari/604.1','YTozOntzOjY6Il90b2tlbiI7czo0MDoieFZMa0l5Z0pBOFdQTEdPOXo0Nk5IVzRuQU1vcDFXTVduUENYYXM1aCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIdHFmc3VieHJuajZoN1hUIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1774221171),
('KDA16wqBuH7cjOxsOsz4jhycD74hgm33fIJSEaUA',NULL,'162.159.106.95','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.61 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiR1hEQXRHM3N3NFRMNXVuTDA4UE9zRk1qSFJHc0dKMmVZNFEzREtmWSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIdHFmc3VieHJuajZoN1hUIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1774237225),
('M8DZYP4lOewbL15ihgYJbbmS5f1mqqMnJhcXCLn5',NULL,'104.23.211.51','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1','YTozOntzOjY6Il90b2tlbiI7czo0MDoiSHRqdFQ4RTM0RGQ5TVRaUTc0ckcyWnZGSkhBbnd0SW9ycjE4WVVnRiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIdHFmc3VieHJuajZoN1hUIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1774227881),
('MH5JGn3Yb4hV2DHaQl3zz1vwGrYCMlfI2NCVHJ2t',NULL,'104.22.17.195','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1','YTozOntzOjY6Il90b2tlbiI7czo0MDoiQWhDN2lQZTVPbVBUNW1yUmt5eHJHQlB4ZDZWV21oV0NvN0QzWEdNMSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIdHFmc3VieHJuajZoN1hUIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1774314219),
('mIS6ErWsPJFWWvymy3YuuwqsfAxz6aQYeVM0VCLM',NULL,'172.71.159.121','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1','YTozOntzOjY6Il90b2tlbiI7czo0MDoiMWFpdTZvWG1GUWtWSXNmc0VkczlXSmNyQVFhZEFYdkhIRzhobTB2OCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIdHFmc3VieHJuajZoN1hUIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1774252120),
('noBjPaDNyWZmKTO42Ge21PMeNMuInWIUZv4tjmmM',NULL,'172.69.222.96','curl/8.7.1','YTozOntzOjY6Il90b2tlbiI7czo0MDoiQXZiSnl1Snl3NmJBQ3d1S21XZFZMODhCZUQxZTRuUTB5MzNUbzZhcSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mby9pbmRleC5waHAiO3M6NToicm91dGUiO3M6Mjc6ImdlbmVyYXRlZDo6SHRxZnN1Ynhybmo2aDdYVCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=',1774302832),
('o6TASV5ad3z6rbCPIPaWpR4Kh4HnBPnjJkvEHEwT',NULL,'104.23.172.107','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11) AppleWebKit/601.1.27 (KHTML, like Gecko) Chrome/47.0.2526.106 Safari/601.1.27','YTozOntzOjY6Il90b2tlbiI7czo0MDoiYU5BSG90Rmx2eEp2UXVHQXAyWml2VWdxRTY4T0k3dGU1QXd0Y3VOWiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIdHFmc3VieHJuajZoN1hUIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1774221134),
('oJVMJ9c7cFg2oLxYICc5EroQAImsB8vCrFHrAGZr',NULL,'172.71.95.89','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.3','YTozOntzOjY6Il90b2tlbiI7czo0MDoiQTZsTXN2OGlxb2szeng5OVowdHdpZnl0ZUl5N0k5RGJiQjhsaHdJNyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIdHFmc3VieHJuajZoN1hUIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1774242833),
('ro6tomAqYRcPQj5QaavlFdjPCJ16MzbKqRijpEg7',NULL,'172.69.39.82','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1','YTozOntzOjY6Il90b2tlbiI7czo0MDoiVjJLdUpVRXhNWHVYSFY4V3VwQ1BNdHlIWmFMampnbVF1bkprMFQ3UiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIdHFmc3VieHJuajZoN1hUIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1774272573),
('rqaLzAQmqexDn7lo1KUWG9cSnMWBwhAVtErK2glu',NULL,'172.71.184.50','Python/3.11 aiohttp/3.11.11','YTozOntzOjY6Il90b2tlbiI7czo0MDoianpOalROdklwVGFwZ2N1YVJMZzJLMUo0UDZ2UTA5MHRnU1F4eW9lciI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIdHFmc3VieHJuajZoN1hUIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1774299145),
('rrCHtkMxoYrdeMzqMJ5FwzFA32kI2zHePiTLmsB7',NULL,'104.23.243.180','visionheight.com/scan Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiY0VOaWZ0VnhoaTJFY2dvanA1Wm9Ia3dFTG02Vmtndzlockhhb1draiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIdHFmc3VieHJuajZoN1hUIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1774299604),
('s6iavu61x0cLD1nK8ZJaqMFEis1a0WodjVeYH61W',NULL,'104.23.229.3','curl/8.7.1','YTozOntzOjY6Il90b2tlbiI7czo0MDoiMjFUV3prQTNkSDFCZHBzZkF2eEVmamJBSnFqZDU1amljb2F5Vk9HbCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIdHFmc3VieHJuajZoN1hUIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1774302722),
('sNETpPqqZKzO2iBrvZBengk6QlHTPOiA3HVwoTIT',NULL,'172.69.222.97','curl/8.7.1','YTozOntzOjY6Il90b2tlbiI7czo0MDoiREdlMDZRbFlZNHZZVFUyZjJzcEZUczRQeDhCd1ZLV2JreFRrejRZbiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDA6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mby8/cD1waHAiO3M6NToicm91dGUiO3M6Mjc6ImdlbmVyYXRlZDo6SHRxZnN1Ynhybmo2aDdYVCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=',1774302772),
('t5JVsdFCe5pOS6zXoaXBdZepnuosiTqg0EknKzXe',NULL,'172.68.151.70','Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity','YTozOntzOjY6Il90b2tlbiI7czo0MDoibUh0WThpcE1jaGxBbGFHUWhkZVNmNHdRbm1FbzJmS3dxNDhBeTM4OCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIdHFmc3VieHJuajZoN1hUIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1774298588),
('TrwQFQewyd9zfbrZmIXDNhnnI2YVrAO5e8G0xpSW',NULL,'104.23.254.156','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.114 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiZXI3cmdiSzlOQk1rc1NDT0k5VU14MFZBOFFHMThxZlY3eFhublZyViI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIdHFmc3VieHJuajZoN1hUIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1774265125),
('tsagyHEoegr9mKQRImAbL7vezW5Q7dSWGmp1b5Np',NULL,'172.70.111.164','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiUlBIZDhySVFRMDNaTEM5RGZIVGRRS2ZRVUJkQk1TU1hMSWtFR2JaOSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIdHFmc3VieHJuajZoN1hUIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1774270461),
('UV1fck9O1OoozX101h1XeR8v7rs5iXATTzoI7Ho3',NULL,'162.158.120.166','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.61 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiRGxZYmhRajF2NHdEbHVET1pKRTBKZnJ2YUZCcGJIYUNiUHF5QnBkUCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIdHFmc3VieHJuajZoN1hUIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1774237508),
('vUpOZZydq6QsLLnLyihCsLQt0L8B8tOymgn8JIq8',NULL,'104.23.170.80','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1','YTozOntzOjY6Il90b2tlbiI7czo0MDoiUXN0ZlV2N3RiRk40eHVRanJWbVdUUkZZcDNYNGt1Z2ZMY21OS1JBbyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIdHFmc3VieHJuajZoN1hUIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1774267725),
('vVMd2xdFuL1ZcrOkx5OgCjnfacbZALzQ66ujPVUt',NULL,'172.69.222.97','curl/8.7.1','YTozOntzOjY6Il90b2tlbiI7czo0MDoiNnpacUJ3dkVhQWp2R0MwQ1doUWdOTlpUQm55eUlndG9KT0J3QVQ2MCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDE6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mby8/cD1pbmZvIjtzOjU6InJvdXRlIjtzOjI3OiJnZW5lcmF0ZWQ6Okh0cWZzdWJ4cm5qNmg3WFQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19',1774302771),
('W3b7VDNxFY64cYjiFchsEuqMgWNF0N38MdKMjxTy',NULL,'172.71.184.50','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36 Edg/121.0.0.0','YTozOntzOjY6Il90b2tlbiI7czo0MDoiWE5JcXc0UXVXd3RjNlR2T0c2SWtHaVl2UFhZNllWUmVZMW5tMGtIeCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIdHFmc3VieHJuajZoN1hUIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1774311447),
('W7XP9ZgPrAnPr5SrEhu1EtTYPsYUXubTOSSqX3NS',NULL,'104.22.62.114','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiMXRKR3hSS1FCVlFicG5KOTVseDNCRE94N1ZGNTRKSXFsZHZ1VDZSQyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIdHFmc3VieHJuajZoN1hUIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1774243990),
('YwPd65qspmZpd5IaeR2fFcAHkZ0QzIOnqgBeugOP',NULL,'172.69.222.97','curl/8.7.1','YTozOntzOjY6Il90b2tlbiI7czo0MDoidHZMbDBrR1RTaVVGRHVpQXd2V2VpT2s0MnIzVEIxZHF3aUpZZkhNQSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mby8/cGhwaW5mbz0iO3M6NToicm91dGUiO3M6Mjc6ImdlbmVyYXRlZDo6SHRxZnN1Ynhybmo2aDdYVCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=',1774302772);
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
  `ref` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_solicitar_ciudad_zona` (`ciudad`,`zona`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `solicitar_ins`
--

LOCK TABLES `solicitar_ins` WRITE;
/*!40000 ALTER TABLE `solicitar_ins` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `solicitar_ins` VALUES
(1,'Yonnel','04129168395','Caracas','Cara','Casa',20000000.00,'Casa','[]',12);
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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
(5,'Luis Mora','mora@fm.com',NULL,3,'$2y$12$Ii9N6HD3LtYVp/EtFpM4oO2hOLAr/FzDyDlaQ9rlcdHlojG24KoDS',NULL,'2026-03-17 23:54:13','2026-03-17 23:54:13'),
(6,'Raul de Cervantes','raul@sm.com',NULL,3,'$2y$12$SiBf9hAOVb57l8iTElY7i.ulP2OHSImH3Z52lWGc55aaTSiQ0HKoi',NULL,'2026-03-19 00:19:52','2026-03-19 00:19:52'),
(7,'pedro casanova','pedro@sm.c',NULL,3,'$2y$12$FVdueLXWGXL54GcPBKmU2ugBhO/AJuy2BsOOpGerBHmjUydy5EXzK',NULL,'2026-03-19 01:19:20','2026-03-19 01:19:20'),
(8,'Yonnel Licon','yon@yon123.com',NULL,3,'$2y$12$aEUG8hThseNtgBbP5WC3..ykDOUg.LvdG66SYMj1aFuIcdQMwSRKG',NULL,'2026-03-19 06:21:12','2026-03-19 06:21:12'),
(9,'Yonnel12 Licon','yon1@gmail.com',NULL,3,'$2y$12$xZpz3XcIu4SprBrdtWhrD.KnZssuC7oqGyG3ClhzWV8MNUedpgFFu',NULL,'2026-03-19 06:35:22','2026-03-19 06:35:22'),
(10,'Luis Bolivar','luis@sm.com',NULL,2,'$2y$12$jd8CdHgY33NvHxkTl6VE6.dzQ235P2HQeK34IyH3uog0OVZIsB1km',NULL,'2026-03-17 23:43:14','2026-03-17 23:43:14'),
(11,'Sara Damasco','sara@sm.com',NULL,3,'$2y$12$7tTyYSPrarwyvTFjw30C.eD5nRPY4BzZnv6Mgr989pE6DYybelL7.',NULL,'2026-03-19 11:08:39','2026-03-19 11:08:39'),
(12,'Pepe Alcaravan','pepe@sm.com',NULL,3,'$2y$12$/dosHsreofOestcn6tGbIuU3X7ZI1pqymfb/WY7KWNlTc8F1Tiv8u',NULL,'2026-03-19 11:09:35','2026-03-19 11:09:35'),
(13,'Maria Oropeza','maria@sm.com',NULL,3,'$2y$12$Kiku5sey8eJljB07NAyXiuHGZ27pn1SRrm644SjSTmPL1dAuH.4L.',NULL,'2026-03-19 12:26:57','2026-03-19 12:26:57'),
(14,'Luis Zerpa','luisz@sm.com',NULL,2,'$2y$12$jd8CdHgY33NvHxkTl6VE6.dzQ235P2HQeK34IyH3uog0OVZIsB1km',NULL,'2026-03-17 23:43:14','2026-03-17 23:43:14'),
(16,'Rafa Pedromo','rafa@sm.com',NULL,3,'$2y$12$wndBId.ep9pEpD2YKDq3c.rP5iep2Fq.cmEDWtp72N9kjq7a3lSFK',NULL,'2026-03-19 12:34:11','2026-03-19 12:34:11');
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

-- Dump completed on 2026-03-23 20:10:24
