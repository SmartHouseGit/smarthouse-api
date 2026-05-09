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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `admins` VALUES
(1,4,0,NULL,NULL,'Laura','Mendoza','+584149998877','Admin senior de operaciones.'),
(2,10,0,NULL,NULL,'Luis ','Bolivar','+584149998877','Admin senior de operaciones.'),
(3,24,22,NULL,NULL,'Yostin','Licon','04145689856','Vendedor profesional');
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
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agentes`
--

LOCK TABLES `agentes` WRITE;
/*!40000 ALTER TABLE `agentes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `agentes` VALUES
(1,0,0,'https://mi-cdn.com/agentes/portada-1.jpg','https://mi-cdn.com/agentes/perfil-1.jpg','Ramona','Mendoza','+584121234567','Asesora comercial con enfoque en inmuebles residenciales.'),
(2,0,0,'https://mi-cdn.com/agentes/portada-2.jpg','https://mi-cdn.com/agentes/perfil-2.jpg','Aup','Mendoza','+584148887766','Especialista en cierre de operaciones y negociacion inmobiliaria.'),
(4,2,0,NULL,NULL,'Mis huevos','Redondos','+584121234567','Asesora comercial con enfoque en inmuebles residenciales.'),
(5,5,4,NULL,NULL,'Luisss','Mora','+584149998877','Asesor inmobiliario'),
(6,6,4,NULL,NULL,'Raul','de Cervantes12','+58 414-110-5522','Captacion y negociacion de propiedades premium con seguimiento personalizado.'),
(7,7,4,NULL,NULL,'pedro','casanova','42566956856','Prof'),
(8,8,4,NULL,NULL,'Yonnel','Licon','04126789078','Yonnel'),
(9,9,4,NULL,NULL,'Yonnel12','Licon','041256789098','Yonnel Moises'),
(11,11,10,NULL,NULL,'Sara','Damasco','+584243073815','Buen Agente'),
(12,12,10,NULL,NULL,'Pepe','Alcaravan','+584243073956','Mejor Agenmte'),
(13,13,10,NULL,NULL,'Maria','Oropeza','+5755656584547','Sin notas add'),
(16,16,14,NULL,NULL,'Rafa','Pedromo','+58424665845','prueba'),
(19,19,4,NULL,NULL,'Yonnel','Licon','041238238213','Vendedor informal'),
(23,23,4,NULL,NULL,'Moises Yon','Licon','04124512048','Nuevo agente'),
(25,25,24,NULL,NULL,'Ramos','Ramos','041456894552','Vendedor'),
(26,26,24,NULL,NULL,'Muffin la bomba','Perro','04226368930','Perro perro'),
(27,27,4,NULL,NULL,'Anderson','Valezquez','04245678908','Anderson, padre de muffin');
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
('laravel-cache-illuminate:queue:restart','i:1774626298;',2089986298),
('laravel-cache-login|anderson@a.a|104.23.248.24','i:1;',1775239434),
('laravel-cache-login|anderson@a.a|104.23.248.24:timer','i:1775239434;',1775239434),
('laravel-cache-login|anderson@a.a|104.23.248.25','i:1;',1775239428),
('laravel-cache-login|anderson@a.a|104.23.248.25:timer','i:1775239428;',1775239428),
('laravel-cache-login|anderson@a.a|172.70.255.67','i:1;',1775239419),
('laravel-cache-login|anderson@a.a|172.70.255.67:timer','i:1775239419;',1775239419),
('laravel-cache-login|luis@sm.com|104.23.245.7','i:1;',1774642978),
('laravel-cache-login|luis@sm.com|104.23.245.7:timer','i:1774642978;',1774642978),
('laravel-cache-login|moi@gmail,com|104.23.248.25','i:2;',1775241094),
('laravel-cache-login|moi@gmail,com|104.23.248.25:timer','i:1775241094;',1775241094),
('laravel-cache-login|moi@gmail,com|172.68.12.50','i:1;',1775241087),
('laravel-cache-login|moi@gmail,com|172.68.12.50:timer','i:1775241087;',1775241087),
('laravel-cache-login|moi@gmail,com|172.70.83.153','i:1;',1775241081),
('laravel-cache-login|moi@gmail,com|172.70.83.153:timer','i:1775241081;',1775241081),
('laravel-cache-login|moises@sm.com|104.23.245.7','i:1;',1774649186),
('laravel-cache-login|moises@sm.com|104.23.245.7:timer','i:1774649186;',1774649186),
('laravel-cache-login|moises@sm.com|172.68.70.116','i:1;',1774647729),
('laravel-cache-login|moises@sm.com|172.68.70.116:timer','i:1774647729;',1774647729),
('laravel-cache-login|moises@sm.com|172.68.70.117','i:1;',1774649102),
('laravel-cache-login|moises@sm.com|172.68.70.117:timer','i:1774649102;',1774649102),
('laravel-cache-login|mora@fm.com|104.23.245.7','i:1;',1774649018),
('laravel-cache-login|mora@fm.com|104.23.245.7:timer','i:1774649018;',1774649018),
('laravel-cache-login|mora@sm.com|104.22.56.188','i:1;',1774645923),
('laravel-cache-login|mora@sm.com|104.22.56.188:timer','i:1774645923;',1774645923),
('laravel-cache-login|mora@sm.com|104.22.56.189','i:2;',1774645853),
('laravel-cache-login|mora@sm.com|104.22.56.189:timer','i:1774645853;',1774645853),
('laravel-cache-login|mora@sm.com|108.162.238.116','i:1;',1774645905),
('laravel-cache-login|mora@sm.com|108.162.238.116:timer','i:1774645905;',1774645905),
('laravel-cache-login|owner@sm.com|172.69.70.198','i:1;',1774653858),
('laravel-cache-login|owner@sm.com|172.69.70.198:timer','i:1774653858;',1774653858),
('laravel-cache-login|perro@sm.com|172.71.31.11','i:2;',1774735585),
('laravel-cache-login|perro@sm.com|172.71.31.11:timer','i:1774735585;',1774735585),
('laravel-cache-login|ramos@sm.com|104.22.1.32','i:1;',1774713627),
('laravel-cache-login|ramos@sm.com|104.22.1.32:timer','i:1774713627;',1774713627),
('laravel-cache-login|ramos@sm.com|104.22.24.235','i:1;',1774713623),
('laravel-cache-login|ramos@sm.com|104.22.24.235:timer','i:1774713623;',1774713623),
('laravel-cache-login|raul@sm.com|104.22.24.234','i:1;',1774660289),
('laravel-cache-login|raul@sm.com|104.22.24.234:timer','i:1774660289;',1774660289),
('laravel-cache-login|raul@sm.com|172.71.31.12','i:1;',1774660207),
('laravel-cache-login|raul@sm.com|172.71.31.12:timer','i:1774660207;',1774660207),
('laravel-cache-login|sameul@sm.com|104.23.245.7','i:1;',1774731968),
('laravel-cache-login|sameul@sm.com|104.23.245.7:timer','i:1774731968;',1774731968),
('laravel-cache-login|yon@sm.com|104.22.24.234','i:1;',1774642997),
('laravel-cache-login|yon@sm.com|104.22.24.234:timer','i:1774642997;',1774642997),
('laravel-cache-login|yon@sm.com|104.23.248.24','i:1;',1775241010),
('laravel-cache-login|yon@sm.com|104.23.248.24:timer','i:1775241010;',1775241010),
('laravel-cache-login|yon@sm.com|172.70.83.154','i:1;',1775241015),
('laravel-cache-login|yon@sm.com|172.70.83.154:timer','i:1775241015;',1775241015),
('laravel-cache-login|yon1@gmail.com|172.68.70.117','i:1;',1774642941),
('laravel-cache-login|yon1@gmail.com|172.68.70.117:timer','i:1774642941;',1774642941),
('laravel-cache-login|yon1@sm.com|104.22.1.32','i:1;',1774642912),
('laravel-cache-login|yon1@sm.com|104.22.1.32:timer','i:1774642912;',1774642912),
('laravel-cache-login|yon1@sm.com|104.22.56.189','i:1;',1774642929),
('laravel-cache-login|yon1@sm.com|104.22.56.189:timer','i:1774642929;',1774642929),
('laravel-cache-login|yon1@sm.com|172.71.31.12','i:1;',1774642923),
('laravel-cache-login|yon1@sm.com|172.71.31.12:timer','i:1774642923;',1774642923),
('laravel-cache-login|yonnel@sm.com|104.22.56.189','i:1;',1774627528),
('laravel-cache-login|yonnel@sm.com|104.22.56.189:timer','i:1774627528;',1774627528),
('laravel-cache-login|yonnel@sm.com|104.23.248.24','i:1;',1775094078),
('laravel-cache-login|yonnel@sm.com|104.23.248.24:timer','i:1775094078;',1775094078),
('laravel-cache-login|yonnel@sm.com|172.70.83.154','i:1;',1775241020),
('laravel-cache-login|yonnel@sm.com|172.70.83.154:timer','i:1775241020;',1775241020);
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cierres`
--

LOCK TABLES `cierres` WRITE;
/*!40000 ALTER TABLE `cierres` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `cierres` VALUES
(1,6,'2026-03-19','Venta','terminado',NULL,'Holas',2000.00,20000.00,4,'Maracay','[\"cierres\\/lvOEqbMHGSNFypdjlIGpafOcPKMEj4ecXuHBTA0C.pdf\"]','sjdsad'),
(2,12,'2026-03-19','Alquiler','Inicial',NULL,'prueba cierre',15000.00,20000.00,11,'Maracay',NULL,'prueba'),
(3,11,'2026-03-19','asesoria','Inicial',NULL,'prueba 2',15680.00,170000.00,7,'Caracas',NULL,'prueba'),
(4,19,'2026-03-26','Venta','terminado',NULL,'Cierre cerrado',20000.00,20000.00,14,'Cagua',NULL,'holas'),
(5,25,'2026-03-28','Venta','Inicial','[\"PUB-0012\"]','Cierre venta | prueba cierre',20000.00,300000.00,NULL,'Caracas','[\"cierres\\/PHVQbG5hGKkTkCRZvWNRr0CQxfwPJq55XlumsHkl.pdf\"]','casa vendida'),
(6,19,'2026-04-03','Venta','terminado','[\"PUB-0006\"]','Cierre venta | Casa preciosa',20000.00,30000.00,14,'Maracay',NULL,'cierre seleccionado');
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ciudades`
--

LOCK TABLES `ciudades` WRITE;
/*!40000 ALTER TABLE `ciudades` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ciudades` VALUES
(5,'Cagua'),
(3,'Caracas'),
(6,'Los teques'),
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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
(4,'clientes/aOpdLTh1ZccTTj3uUNjEZXrG8gp7vpEBQ1qfyLn9.png','clientes/NI7OR4PwpuiCpTVOA3pbUqZN3h8tG7vNvIj0DSlk.jpg','ElXokas','Streamer','Comprador','Activo','0412345678','daso@gamil.com','daso','Maracay','1238213812123','daso\n\nTipo API: Comprador',6),
(5,'clientes/vq5DdZRqCtUR296qBxFloXczZLlTSgJPMwEHwt3Q.png','clientes/x06BZoPyiDswJY0j1PXzSbVVuBTb5eTGce9fOsdl.jpg','nose','nose','Corporativo','Activo','04123503289','nose@gmail.com','nose','Caracas','83839393','nose',6),
(6,'clientes/vDLKe6IyeYOOruZaXYThrR0WQnFDSrKIRr1sqjv6.jpg','clientes/EyzJ8NcnjiERwBFkNiGFDEwJa4Ts8f7hE449guC2.jpg','Cliente 1','prueba cliente natural','Comprador','Activo','+584246956685','cliente1@sm.com','maracay','Maracay','12456865','Sin nota ocupable',11),
(7,'clientes/B9fXXHDejS0vETbZMLIEF8D2eRBycNVldyQT5unk.jpg','clientes/Ci9UHZCqDhRVbG0OZO32SDxyXQBuxQ7aaVTNIIhF.jpg','Corp 1','perfilde prueba corp','Corporativo','Activo','+575132454474','corp1@sm.com','bogota','bogota','457598158415','prueba corp 1',11),
(11,'clientes/LNrXGTaa2psJWJX5z14vvrCpleulHawrCipkw3sc.jpg','clientes/QdSSEsAUI6ermDCvmJEzoev0cV755VUm9tKEnpJ8.jpg','CLiente 6','prueba','Comprador','Activo','654984864646','cliente6@sm.com','sffefwe','Valencia','4816498','sin nota',12),
(12,'clientes/TIgvn3MQNJqVQ4jxL7jbiZrnJ00ULXpCduFiOu38.png','clientes/kf3hWKsiP00lQUga9X7UDsYPiozupxhePwUxjePN.png','Ranso','Comprador premium','Comprador','Nuevo','041223823993','rank@1.com','Altamira','Caracas','373782829','Comprador',6),
(13,'clientes/aTYwqiAiUU1Ogh8HSeRezqDx7vi8QaQgwRr0tdR5.jpg','clientes/5yoGk14RQtbjyb2dk6yMUaeqRVXxy13UwvuSchnZ.png','Reis','Comprador inversionista','Corporativo','Nuevo','0412482948','yonn@a.com','Su casa','Villa de cura','38213812','Casita',6),
(14,'clientes/xflgCO0glNu2X6M0asBAcTSdGOyQM2xVbReFERD0.jpg','clientes/E09RWz3IzkT1JNluxCqt8g9Eb4ifzHWRB338CPrG.png','dasdsa','hdsdhsdh','Comprador','Nuevo','312312312','sdjasd@gmail.com','sjsj','Maracay','2312312','jsadjkasdksajdasdj',19),
(15,'clientes/5kj4alP1wyesbLKzvYn8HZ9f0HWiBV5rBvjuqVd7.png','clientes/pv7uVVMaqMJw5ri7IS1UkRa8QHq4seayqiqS4z8l.png','hsdh','jkjkk','Corporativo','Nuevo','0123213123','hasdjasd@a.com','ksdjkasd','Maracay','2831287','lkl',19),
(16,'clientes/UDuiYf2dWnluofgi6X6dgeThm8koOKuSCroc6ORm.jpg','clientes/vlqgFLf1Kgbep4yOrLBtox4jeA2tidYmNiCfXVlX.jpg','Encargado de propiedades','premium','Corporativo','Nuevo','04129168395','yon@gmail.com','Su casa','Los teques','2546984652','Casa preciosa en los teques',19);
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
(1,'Tu hogar ideal, sin complicaciones','config/LVLSL4E1AQz9yudpv8cvWTuwOyrCudCbWpqwPp56.png','[{\"titulo\":\"Holas a todos\",\"valor\":\"Hello mundo\"}]','[{\"titulo\":\"Casa preciosa en Cagua\",\"valor\":\"5\"},{\"titulo\":\"Residencias en casa\",\"valor\":\"1\"},{\"titulo\":\"Mejor\",\"valor\":\"3\"}]','[\"config\\/AIJwYWurkE24d9uBfIQhbhT7Bn2CpVsW3SiUPBZR.jpg\"]','[{\"nombre\":\"Se\\u00f1or Jos\\u00e9\",\"subtitulo\":\"Lider\",\"comentario\":\"Casa espectacular, trato incre\\u00edble\"},{\"nombre\":\"Dra. Mar\\u00eda Perez\",\"subtitulo\":\"Ingeniera Civil\",\"comentario\":\"Hogares de alto nivel para personas de alto nivel\"}]');
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
  `ref` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_contactos_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contactos`
--

LOCK TABLES `contactos` WRITE;
/*!40000 ALTER TABLE `contactos` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `contactos` VALUES
(1,1,'Yonn','Yonnn@gmail.com','Comprar para vivir','Prueba 1',11),
(2,1,'Moises','Moi@gmail.com','Comprar para vivir','Yonnel',6),
(3,1,'gfdg','fdg@gmail.com','Comprar para vivir','asdasd',8),
(4,2,'asdasd','sad@gmail.com','Asesor comercial senior','asdsa',6),
(5,1,'Moises','uo@gmail.com','Comprar para vivir','hokak',25);
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
) ENGINE=InnoDB AUTO_INCREMENT=184 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loan_cuts`
--

LOCK TABLES `loan_cuts` WRITE;
/*!40000 ALTER TABLE `loan_cuts` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `loan_cuts` VALUES
(89,23,1,'2026-04-03','2026-04-03',1000.00,0.00,1000.00,'pending',NULL,NULL,NULL,'2026-03-24 02:32:52','2026-03-24 02:32:52'),
(90,23,2,'2026-05-03','2026-05-03',51000.00,0.00,51000.00,'pending',NULL,NULL,NULL,'2026-03-24 02:32:52','2026-03-24 02:32:52'),
(91,24,1,'2026-02-01','2026-02-01',500.00,0.00,500.00,'paid','Pago móvil','loans/proofs/ZmTJBoS42RORpGRifaPtL1B0AkQCk8t4lH8aoEoG.png','2026-03-24 02:38:46','2026-03-24 02:36:59','2026-03-24 02:38:46'),
(92,24,2,'2026-03-01','2026-03-01',500.00,0.00,500.00,'paid','Pago móvil','loans/proofs/VB3pL8eEDRIQ5cnpIe2nP2agcGvIZbP0QFzj5rXF.png','2026-03-24 02:39:25','2026-03-24 02:36:59','2026-03-24 02:39:25'),
(93,24,3,'2026-04-01','2026-04-01',500.00,0.00,500.00,'pending',NULL,NULL,NULL,'2026-03-24 02:36:59','2026-03-24 02:36:59'),
(94,24,4,'2026-05-01','2026-05-01',500.00,0.00,500.00,'pending',NULL,NULL,NULL,'2026-03-24 02:36:59','2026-03-24 02:36:59'),
(95,24,5,'2026-06-01','2026-06-01',500.00,0.00,500.00,'pending',NULL,NULL,NULL,'2026-03-24 02:36:59','2026-03-24 02:36:59'),
(96,24,6,'2026-07-01','2026-07-01',500.00,0.00,500.00,'pending',NULL,NULL,NULL,'2026-03-24 02:36:59','2026-03-24 02:36:59'),
(97,24,7,'2026-08-01','2026-08-01',500.00,0.00,500.00,'pending',NULL,NULL,NULL,'2026-03-24 02:36:59','2026-03-24 02:36:59'),
(98,24,8,'2026-09-01','2026-09-01',500.00,0.00,500.00,'pending',NULL,NULL,NULL,'2026-03-24 02:36:59','2026-03-24 02:36:59'),
(99,24,9,'2026-10-01','2026-10-01',500.00,0.00,500.00,'pending',NULL,NULL,NULL,'2026-03-24 02:36:59','2026-03-24 02:36:59'),
(100,24,10,'2026-11-01','2026-11-01',500.00,0.00,500.00,'pending',NULL,NULL,NULL,'2026-03-24 02:36:59','2026-03-24 02:36:59'),
(101,24,11,'2026-12-01','2026-12-01',500.00,0.00,500.00,'pending',NULL,NULL,NULL,'2026-03-24 02:36:59','2026-03-24 02:36:59'),
(102,24,12,'2027-01-01','2027-01-01',10500.00,0.00,10500.00,'pending',NULL,NULL,NULL,'2026-03-24 02:36:59','2026-03-24 02:36:59'),
(103,25,1,'2025-02-07','2025-02-07',15.00,0.00,15.00,'paid','Pago usdt','loans/proofs/teQylN9dcmzs2g5sn8HEHGEQPlGyHqf0vuGKiIEu.jpg','2026-03-24 03:19:12','2026-03-24 03:18:11','2026-03-24 03:19:12'),
(104,25,2,'2025-03-07','2025-03-07',15.00,0.00,15.00,'paid','Usdt','loans/proofs/CmQZHw4m3aX3kmnE09I3oGHJZTbnpB5JuzOiYyxL.jpg','2026-03-24 03:19:43','2026-03-24 03:18:11','2026-03-24 03:19:43'),
(105,25,3,'2025-04-07','2025-04-07',15.00,0.00,15.00,'paid','Usdt','loans/proofs/rmi5o1XNDxuqbnoAsSUfFbyfzxxZqcAOyKeJjj4H.jpg','2026-03-24 03:20:06','2026-03-24 03:18:11','2026-03-24 03:20:06'),
(106,25,4,'2025-05-07','2025-05-07',15.00,0.00,15.00,'paid','Pago','loans/proofs/SDUVKCn5trM4x3Fg5C38jYQx1oljl0cqcCFC59ZC.jpg','2026-03-24 03:20:27','2026-03-24 03:18:11','2026-03-24 03:20:27'),
(107,25,5,'2025-06-07','2025-06-07',15.00,0.00,15.00,'paid',NULL,'loans/proofs/0BuwygVAvEy6ywx5UfcfgUnhrmTMSH6QsWUmZoXN.jpg','2026-03-24 03:20:39','2026-03-24 03:18:11','2026-03-24 03:20:39'),
(108,25,6,'2025-07-07','2025-07-07',15.00,0.00,15.00,'paid','Usdt','loans/proofs/GOOldBKommtJd55XEVZXelQW8MPEzjzfXTGL1EQ3.jpg','2026-03-24 03:20:53','2026-03-24 03:18:11','2026-03-24 03:20:53'),
(109,25,7,'2025-08-07','2025-08-07',15.00,0.00,15.00,'paid',NULL,'loans/proofs/eL6bHJ8BAesKPrDMRtMAx4CLzsH5WdsBJSyfOpTz.jpg','2026-03-24 03:21:09','2026-03-24 03:18:11','2026-03-24 03:21:09'),
(110,25,8,'2025-09-07','2025-09-07',15.00,0.00,15.00,'paid','Usdt','loans/proofs/7aVaAPgtRHm6wdbdYgr1ZbRZgtAKtpdK92gY8bTS.jpg','2026-03-24 03:21:46','2026-03-24 03:18:11','2026-03-24 03:21:46'),
(111,25,9,'2025-10-07','2025-10-07',15.00,0.00,15.00,'paid','Usdt','loans/proofs/8RDCTMtvAdMwYwNB7y3SgEDczvqs4ac7DS4OUn1i.jpg','2026-03-24 03:22:24','2026-03-24 03:18:11','2026-03-24 03:22:24'),
(112,25,10,'2025-11-07','2025-11-07',15.00,0.00,15.00,'paid','Usdt','loans/proofs/NeddDw8ANYy4ZkXWe5Pld7jL3Wx2x20iqzlmxk83.jpg','2026-03-24 03:22:40','2026-03-24 03:18:11','2026-03-24 03:22:40'),
(113,25,11,'2025-12-07','2025-12-07',15.00,0.00,15.00,'paid','Usdt','loans/proofs/Nf8CdfsHGaLYeICTjZiukns8SWY7wP6LUgnTZesE.jpg','2026-03-24 03:23:06','2026-03-24 03:18:11','2026-03-24 03:23:06'),
(114,25,12,'2026-01-07','2026-01-07',15.00,0.00,15.00,'paid','Usdt','loans/proofs/XEeupJKXMI1qs4hLYsVu4vEqmJ11fLCpAAsqjQdo.jpg','2026-03-24 03:23:22','2026-03-24 03:18:11','2026-03-24 03:23:22'),
(115,25,13,'2026-02-07','2026-02-07',15.00,0.00,15.00,'paid','Usdt','loans/proofs/BVCJb8DZbjpu0bBFr9b1lpAcEvVs51m2QTZM0h1X.jpg','2026-03-24 03:24:20','2026-03-24 03:18:11','2026-03-24 03:24:20'),
(116,25,14,'2026-03-07','2026-03-07',15.00,0.00,15.00,'paid','Usdt','loans/proofs/dzSPBIrPFtQ3rsBzQnLhCsYs3vLXXmAyNWMXBKwy.jpg','2026-03-24 03:24:37','2026-03-24 03:18:11','2026-03-24 03:24:37'),
(117,25,15,'2026-04-07','2026-04-07',15.00,0.00,15.00,'pending',NULL,NULL,NULL,'2026-03-24 03:18:11','2026-03-24 03:18:11'),
(118,25,16,'2026-05-07','2026-05-07',15.00,0.00,15.00,'pending',NULL,NULL,NULL,'2026-03-24 03:18:11','2026-03-24 03:18:11'),
(119,25,17,'2026-06-07','2026-06-07',15.00,0.00,15.00,'pending',NULL,NULL,NULL,'2026-03-24 03:18:11','2026-03-24 03:18:11'),
(120,25,18,'2026-07-07','2026-07-07',15.00,0.00,15.00,'pending',NULL,NULL,NULL,'2026-03-24 03:18:11','2026-03-24 03:18:11'),
(121,25,19,'2026-08-07','2026-08-07',15.00,0.00,15.00,'pending',NULL,NULL,NULL,'2026-03-24 03:18:11','2026-03-24 03:18:11'),
(122,25,20,'2026-09-07','2026-09-07',15.00,0.00,15.00,'pending',NULL,NULL,NULL,'2026-03-24 03:18:11','2026-03-24 03:18:11'),
(123,25,21,'2026-10-07','2026-10-07',15.00,0.00,15.00,'pending',NULL,NULL,NULL,'2026-03-24 03:18:11','2026-03-24 03:18:11'),
(124,25,22,'2026-11-07','2026-11-07',15.00,0.00,15.00,'pending',NULL,NULL,NULL,'2026-03-24 03:18:11','2026-03-24 03:18:11'),
(125,25,23,'2026-12-07','2026-12-07',15.00,0.00,15.00,'pending',NULL,NULL,NULL,'2026-03-24 03:18:11','2026-03-24 03:18:11'),
(126,25,24,'2027-01-07','2027-01-07',15.00,0.00,15.00,'pending',NULL,NULL,NULL,'2026-03-24 03:18:11','2026-03-24 03:18:11'),
(127,25,25,'2027-02-07','2027-02-07',15.00,0.00,15.00,'pending',NULL,NULL,NULL,'2026-03-24 03:18:11','2026-03-24 03:18:11'),
(128,25,26,'2027-03-07','2027-03-07',15.00,0.00,15.00,'pending',NULL,NULL,NULL,'2026-03-24 03:18:11','2026-03-24 03:18:11'),
(129,25,27,'2027-04-07','2027-04-07',15.00,0.00,15.00,'pending',NULL,NULL,NULL,'2026-03-24 03:18:11','2026-03-24 03:18:11'),
(130,25,28,'2027-05-07','2027-05-07',15.00,0.00,15.00,'pending',NULL,NULL,NULL,'2026-03-24 03:18:11','2026-03-24 03:18:11'),
(131,25,29,'2027-06-07','2027-06-07',15.00,0.00,15.00,'pending',NULL,NULL,NULL,'2026-03-24 03:18:11','2026-03-24 03:18:11'),
(132,25,30,'2027-07-07','2027-07-07',15.00,0.00,15.00,'pending',NULL,NULL,NULL,'2026-03-24 03:18:11','2026-03-24 03:18:11'),
(133,25,31,'2027-08-07','2027-08-07',15.00,0.00,15.00,'pending',NULL,NULL,NULL,'2026-03-24 03:18:11','2026-03-24 03:18:11'),
(134,25,32,'2027-09-07','2027-09-07',15.00,0.00,15.00,'pending',NULL,NULL,NULL,'2026-03-24 03:18:11','2026-03-24 03:18:11'),
(135,25,33,'2027-10-07','2027-10-07',15.00,0.00,15.00,'pending',NULL,NULL,NULL,'2026-03-24 03:18:11','2026-03-24 03:18:11'),
(136,25,34,'2027-11-07','2027-11-07',15.00,0.00,15.00,'pending',NULL,NULL,NULL,'2026-03-24 03:18:11','2026-03-24 03:18:11'),
(137,25,35,'2027-12-07','2027-12-07',15.00,0.00,15.00,'pending',NULL,NULL,NULL,'2026-03-24 03:18:11','2026-03-24 03:18:11'),
(138,25,36,'2028-01-07','2028-01-07',1515.00,0.00,1515.00,'pending',NULL,NULL,NULL,'2026-03-24 03:18:11','2026-03-24 03:18:11'),
(139,26,1,'2026-04-07','2026-04-07',5600.00,0.00,5600.00,'pending',NULL,NULL,NULL,'2026-03-24 10:32:40','2026-03-24 10:32:40'),
(140,26,2,'2026-05-07','2026-05-07',5600.00,0.00,5600.00,'pending',NULL,NULL,NULL,'2026-03-24 10:32:40','2026-03-24 10:32:40'),
(141,26,3,'2026-06-07','2026-06-07',5600.00,0.00,5600.00,'pending',NULL,NULL,NULL,'2026-03-24 10:32:40','2026-03-24 10:32:40'),
(142,26,4,'2026-07-07','2026-07-07',5600.00,0.00,5600.00,'pending',NULL,NULL,NULL,'2026-03-24 10:32:40','2026-03-24 10:32:40'),
(143,26,5,'2026-08-07','2026-08-07',5600.00,0.00,5600.00,'pending',NULL,NULL,NULL,'2026-03-24 10:32:40','2026-03-24 10:32:40'),
(144,26,6,'2026-09-07','2026-09-07',5600.00,0.00,5600.00,'pending',NULL,NULL,NULL,'2026-03-24 10:32:40','2026-03-24 10:32:40'),
(145,26,7,'2026-10-07','2026-10-07',5600.00,0.00,5600.00,'pending',NULL,NULL,NULL,'2026-03-24 10:32:40','2026-03-24 10:32:40'),
(146,26,8,'2026-11-07','2026-11-07',5600.00,0.00,5600.00,'pending',NULL,NULL,NULL,'2026-03-24 10:32:40','2026-03-24 10:32:40'),
(147,26,9,'2026-12-07','2026-12-07',85600.00,0.00,85600.00,'pending',NULL,NULL,NULL,'2026-03-24 10:32:40','2026-03-24 10:32:40'),
(148,27,1,'2026-04-07','2026-04-07',3000.00,0.00,3000.00,'pending',NULL,NULL,NULL,'2026-03-24 10:36:08','2026-03-24 10:36:08'),
(149,27,2,'2026-05-07','2026-05-07',3000.00,0.00,3000.00,'pending',NULL,NULL,NULL,'2026-03-24 10:36:08','2026-03-24 10:36:08'),
(150,27,3,'2026-06-07','2026-06-07',33000.00,0.00,33000.00,'pending',NULL,NULL,NULL,'2026-03-24 10:36:08','2026-03-24 10:36:08'),
(151,28,1,'2026-05-01','2026-05-01',60.00,0.00,60.00,'pending',NULL,NULL,NULL,'2026-03-24 21:36:21','2026-03-24 21:36:21'),
(152,28,2,'2026-06-01','2026-06-01',60.00,0.00,60.00,'pending',NULL,NULL,NULL,'2026-03-24 21:36:21','2026-03-24 21:36:21'),
(153,28,3,'2026-07-01','2026-07-01',60.00,0.00,60.00,'pending',NULL,NULL,NULL,'2026-03-24 21:36:21','2026-03-24 21:36:21'),
(154,28,4,'2026-08-01','2026-08-01',60.00,0.00,60.00,'pending',NULL,NULL,NULL,'2026-03-24 21:36:21','2026-03-24 21:36:21'),
(155,28,5,'2026-09-01','2026-09-01',60.00,0.00,60.00,'pending',NULL,NULL,NULL,'2026-03-24 21:36:21','2026-03-24 21:36:21'),
(156,28,6,'2026-10-01','2026-10-01',60.00,0.00,60.00,'pending',NULL,NULL,NULL,'2026-03-24 21:36:21','2026-03-24 21:36:21'),
(157,28,7,'2026-11-01','2026-11-01',60.00,0.00,60.00,'pending',NULL,NULL,NULL,'2026-03-24 21:36:21','2026-03-24 21:36:21'),
(158,28,8,'2026-12-01','2026-12-01',60.00,0.00,60.00,'pending',NULL,NULL,NULL,'2026-03-24 21:36:21','2026-03-24 21:36:21'),
(159,28,9,'2027-01-01','2027-01-01',60.00,0.00,60.00,'pending',NULL,NULL,NULL,'2026-03-24 21:36:21','2026-03-24 21:36:21'),
(160,28,10,'2027-02-01','2027-02-01',60.00,0.00,60.00,'pending',NULL,NULL,NULL,'2026-03-24 21:36:21','2026-03-24 21:36:21'),
(161,28,11,'2027-03-01','2027-03-01',60.00,0.00,60.00,'pending',NULL,NULL,NULL,'2026-03-24 21:36:21','2026-03-24 21:36:21'),
(162,28,12,'2027-04-01','2027-04-01',6060.00,0.00,6060.00,'pending',NULL,NULL,NULL,'2026-03-24 21:36:21','2026-03-24 21:36:21'),
(163,29,1,'2026-03-25','2026-03-25',1200.00,0.00,1200.00,'pending',NULL,NULL,NULL,'2026-03-25 21:31:22','2026-03-25 17:33:46'),
(164,29,2,'2026-05-25','2026-05-25',1200.00,0.00,1200.00,'pending',NULL,NULL,NULL,'2026-03-25 21:31:22','2026-03-25 21:31:22'),
(165,29,3,'2026-06-25','2026-06-25',13200.00,0.00,13200.00,'pending',NULL,NULL,NULL,'2026-03-25 21:31:22','2026-03-25 21:31:22'),
(166,30,1,'2026-03-25','2026-03-25',200.00,0.00,200.00,'pending',NULL,NULL,NULL,'2026-03-25 21:34:04','2026-03-25 17:34:49'),
(167,30,2,'2026-05-25','2026-05-25',200.00,0.00,200.00,'pending',NULL,NULL,NULL,'2026-03-25 21:34:04','2026-03-25 21:34:04'),
(168,30,3,'2026-06-25','2026-06-25',2200.00,0.00,2200.00,'pending',NULL,NULL,NULL,'2026-03-25 21:34:04','2026-03-25 21:34:04'),
(172,32,1,'2026-02-01','2026-02-01',18090.00,0.00,18090.00,'paid','Pago cash o fina','loans/proofs/9dQWVwuqW4sgpiPPR1jvFYakmfIqPqHoWjkNIPfb.jpg','2026-03-30 14:53:48','2026-03-29 19:30:24','2026-03-30 18:53:48'),
(173,32,2,'2026-03-01','2026-03-01',18090.00,0.00,18090.00,'paid','Pago cash oficina','loans/proofs/DFhIHQj540K3udQbZdk9WBNnEhxVUyVXcXzpPAEn.jpg','2026-03-30 14:54:21','2026-03-29 19:30:24','2026-03-30 18:54:21'),
(174,32,3,'2026-04-01','2026-04-01',18090.00,0.00,18090.00,'pending',NULL,NULL,NULL,'2026-03-29 19:30:24','2026-03-29 19:30:24'),
(175,32,4,'2026-05-01','2026-05-01',18090.00,0.00,18090.00,'pending',NULL,NULL,NULL,'2026-03-29 19:30:24','2026-03-29 19:30:24'),
(176,32,5,'2026-06-01','2026-06-01',18090.00,0.00,18090.00,'pending',NULL,NULL,NULL,'2026-03-29 19:30:24','2026-03-29 19:30:24'),
(177,32,6,'2026-07-01','2026-07-01',18090.00,0.00,18090.00,'pending',NULL,NULL,NULL,'2026-03-29 19:30:24','2026-03-29 19:30:24'),
(178,32,7,'2026-08-01','2026-08-01',18090.00,0.00,18090.00,'pending',NULL,NULL,NULL,'2026-03-29 19:30:24','2026-03-29 19:30:24'),
(179,32,8,'2026-09-01','2026-09-01',18090.00,0.00,18090.00,'pending',NULL,NULL,NULL,'2026-03-29 19:30:24','2026-03-29 19:30:24'),
(180,32,9,'2026-10-01','2026-10-01',18090.00,0.00,18090.00,'pending',NULL,NULL,NULL,'2026-03-29 19:30:24','2026-03-29 19:30:24'),
(181,32,10,'2026-11-01','2026-11-01',18090.00,0.00,18090.00,'pending',NULL,NULL,NULL,'2026-03-29 19:30:24','2026-03-29 19:30:24'),
(182,32,11,'2026-12-01','2026-12-01',18090.00,0.00,18090.00,'pending',NULL,NULL,NULL,'2026-03-29 19:30:24','2026-03-29 19:30:24'),
(183,32,12,'2027-01-01','2027-01-01',688090.00,0.00,688090.00,'pending',NULL,NULL,NULL,'2026-03-29 19:30:24','2026-03-29 19:30:24');
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
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loans`
--

LOCK TABLES `loans` WRITE;
/*!40000 ALTER TABLE `loans` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `loans` VALUES
(23,'Gaby Kalach','15609471',50000.00,'mensual',2,2.0000,1000.00,51000.00,2000.00,52000.00,'2026-03-03','2026-05-03','active',17,17,'2026-03-24 02:32:52','2026-03-24 02:32:52'),
(24,'Adrián Proautos','11922250',10000.00,'mensual',12,5.0000,500.00,10500.00,6000.00,16000.00,'2026-01-01','2027-01-01','active',17,17,'2026-03-24 02:36:59','2026-03-24 02:36:59'),
(25,'Juan Carlos','13345777',1500.00,'mensual',36,1.0000,15.00,1515.00,540.00,2040.00,'2025-01-07','2028-01-07','active',17,17,'2026-03-24 03:18:11','2026-03-24 03:18:11'),
(26,'Jeiver Victora','25662184',80000.00,'mensual',9,7.0000,5600.00,85600.00,50400.00,130400.00,'2026-03-07','2026-12-07','active',17,17,'2026-03-24 10:32:40','2026-03-24 10:32:40'),
(27,'Carlos Gaviria','19531106',30000.00,'mensual',3,10.0000,3000.00,33000.00,9000.00,39000.00,'2026-03-07','2026-06-07','active',17,17,'2026-03-24 10:36:08','2026-03-24 19:56:10'),
(28,'Freddy Arguello','18230702',6000.00,'mensual',12,1.0000,60.00,6060.00,720.00,6720.00,'2026-04-01','2027-04-01','active',17,17,'2026-03-24 21:36:21','2026-03-24 21:36:21'),
(29,'prueba','15245411',12000.00,'mensual',3,10.0000,1200.00,13200.00,3600.00,15600.00,'2026-03-25','2026-06-25','active',20,20,'2026-03-25 21:31:22','2026-03-25 21:31:22'),
(30,'Muffin','42542542',2000.00,'mensual',3,10.0000,200.00,2200.00,600.00,2600.00,'2026-03-25','2026-06-25','active',NULL,NULL,'2026-03-25 21:34:04','2026-03-25 21:34:04'),
(32,'Deliplaza','15609424',670000.00,'mensual',12,2.7000,18090.00,688090.00,217080.00,887080.00,'2026-01-01','2027-01-01','active',18,18,'2026-03-29 19:30:24','2026-03-29 19:30:24');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mensajes`
--

LOCK TABLES `mensajes` WRITE;
/*!40000 ALTER TABLE `mensajes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `mensajes` VALUES
(1,4,0,'[8]','alta','charla','debemos charlar','2026-03-25 21:57:05'),
(2,4,0,'[5,6,7,8,9,19]','media','Hola','Holaa','2026-03-26 01:15:41'),
(3,4,0,'[6]','media','Hola','Prueba 2','2026-03-26 01:40:33');
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
) ENGINE=InnoDB AUTO_INCREMENT=180 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
(37,'App\\Models\\User',4,'frontend','93b468716735f8eb9a889180ad76c2b54f2c9c9f8ff7d4e76523be17c0426f39','[\"*\"]','2026-03-23 11:28:05',NULL,'2026-03-23 11:24:57','2026-03-23 11:28:05'),
(38,'App\\Models\\User',17,'frontend','360b615819cd5f4ab7ccba89bff6ff19e4dfb425969a0f3429746ea95a937100','[\"*\"]','2026-03-24 01:26:28',NULL,'2026-03-24 01:24:58','2026-03-24 01:26:28'),
(39,'App\\Models\\User',18,'frontend','37dadb7ad309846cc95688967cf439a72a297edfe857ffa189cdf60a5f320440','[\"*\"]','2026-03-24 01:28:30',NULL,'2026-03-24 01:26:28','2026-03-24 01:28:30'),
(40,'App\\Models\\User',17,'frontend','2b771121f9d3ca62645a6705c2f0302586d26f6177e235fc864ba377afc8d120','[\"*\"]','2026-03-24 01:39:41',NULL,'2026-03-24 01:26:53','2026-03-24 01:39:41'),
(41,'App\\Models\\User',18,'frontend','64676c0f2bc6508c9e50abc86ee23830163f66e87df7a89e017c17dc8b2b9328','[\"*\"]','2026-03-25 20:47:14',NULL,'2026-03-24 01:28:47','2026-03-25 20:47:14'),
(42,'App\\Models\\User',18,'frontend','528842d3059f90606d856998b5f286c65ca49665ff4f8bba5e856deb5b3f2cbf','[\"*\"]','2026-03-24 01:41:02',NULL,'2026-03-24 01:39:56','2026-03-24 01:41:02'),
(43,'App\\Models\\User',18,'frontend','3f8c52196d7698c331ca9736ec31cbe06fd0f9cee2330bc06c64a04b75187aa7','[\"*\"]','2026-03-25 21:09:17',NULL,'2026-03-24 01:41:10','2026-03-25 21:09:17'),
(44,'App\\Models\\User',17,'frontend','40e4146bc24dc027410d8d9efc7468e8c555786b0d4ab5b70b7a2ec1ce99bec3','[\"*\"]','2026-04-01 23:00:11',NULL,'2026-03-24 01:54:24','2026-04-01 23:00:11'),
(45,'App\\Models\\User',18,'frontend','ab341ea52ac394af25d8e0b265a4f902b05b9cdbf03b6053ebfd509f24d6caaf','[\"*\"]','2026-03-25 20:40:11',NULL,'2026-03-24 14:29:56','2026-03-25 20:40:11'),
(46,'App\\Models\\User',18,'frontend','75876de5881f456e4a4bbe49e8b13dba0c781b449d1635d4a44835f42081080d','[\"*\"]','2026-03-24 15:15:12',NULL,'2026-03-24 15:15:12','2026-03-24 15:15:12'),
(47,'App\\Models\\User',18,'frontend','91dbbb09c1b33ab147a633265a3c087e31df98d59789f15c145632ad129d3395','[\"*\"]','2026-03-24 17:06:39',NULL,'2026-03-24 15:20:18','2026-03-24 17:06:39'),
(48,'App\\Models\\User',18,'frontend','d63e7986cbf9fa0323c08bd464aacb87940c853d861e7ccafa6bd5d7d5254139','[\"*\"]','2026-04-02 03:01:09',NULL,'2026-03-24 17:07:04','2026-04-02 03:01:09'),
(49,'App\\Models\\User',4,'frontend','419759ab5badfd4a9a86a698c2006e1ed63a495d57baa4dd97fa474322371fe8','[\"*\"]','2026-03-25 03:48:22',NULL,'2026-03-25 00:40:30','2026-03-25 03:48:22'),
(50,'App\\Models\\User',6,'frontend','239bcfc727a5b7b36aed78bbf25b225b6683a0842669a6befa4ba26633e9004e','[\"*\"]','2026-03-25 15:57:31',NULL,'2026-03-25 03:51:21','2026-03-25 15:57:31'),
(51,'App\\Models\\User',4,'frontend','f78e2aa09ab6066f82c346d4ad51eaa4b9b172bfa8404c2e9eb7bbe30c89b890','[\"*\"]','2026-03-25 15:58:53',NULL,'2026-03-25 15:58:20','2026-03-25 15:58:53'),
(52,'App\\Models\\User',4,'frontend','0573d1e2c7c0198993e3b038faeef207156dcf404515a3852a39c348a71d85d0','[\"*\"]','2026-03-25 16:00:38',NULL,'2026-03-25 16:00:27','2026-03-25 16:00:38'),
(53,'App\\Models\\User',4,'frontend','803a0ea11cd696d151d6a8a334fba88df22317199eff70ec23be45cf7a503b93','[\"*\"]','2026-03-25 16:00:59',NULL,'2026-03-25 16:00:57','2026-03-25 16:00:59'),
(54,'App\\Models\\User',6,'frontend','b0495678f40192c1be50aa273c09f0b60f7c35587fe5da966662b9e07ae18159','[\"*\"]','2026-03-25 16:01:28',NULL,'2026-03-25 16:01:28','2026-03-25 16:01:28'),
(55,'App\\Models\\User',6,'frontend','e482c84ce04ddb26b2ee26a4c5b0c74800224fefb4bfd2241e8f6db8ba700e73','[\"*\"]','2026-03-25 16:29:41',NULL,'2026-03-25 16:02:13','2026-03-25 16:29:41'),
(56,'App\\Models\\User',4,'frontend','7fafe263565c5cb27460fc8dbd31771f67036d260d70fdc44c36880d621a2338','[\"*\"]','2026-03-25 16:37:01',NULL,'2026-03-25 16:36:02','2026-03-25 16:37:01'),
(57,'App\\Models\\User',19,'frontend','c3a0862821a3b42a7d2b2369a1894230a6486a7189faa88d5730680eed02eca5','[\"*\"]','2026-03-25 16:37:34',NULL,'2026-03-25 16:37:33','2026-03-25 16:37:34'),
(58,'App\\Models\\User',4,'frontend','c1538c7a8d9ae8bd73a1a1f4558209ed913b16b7310b16f5ab887f5d84e676c4','[\"*\"]','2026-03-25 16:51:57',NULL,'2026-03-25 16:39:07','2026-03-25 16:51:57'),
(59,'App\\Models\\User',4,'frontend','194fdc3590011d981943386c8ff995c62475ff307770435de020a7578c666db3','[\"*\"]','2026-03-25 16:52:53',NULL,'2026-03-25 16:52:13','2026-03-25 16:52:53'),
(60,'App\\Models\\User',19,'frontend','c5b905260973f964e1e23d8b3db2e85b67c76e53c8fd2b94a7015a1d7463e9e1','[\"*\"]','2026-03-25 16:54:31',NULL,'2026-03-25 16:54:31','2026-03-25 16:54:31'),
(61,'App\\Models\\User',19,'frontend','87df2d06b07f7bc2143dc22aef5aff42365bcbc2813c34ebd92452cdfeac7b4d','[\"*\"]','2026-03-25 16:57:23',NULL,'2026-03-25 16:57:23','2026-03-25 16:57:23'),
(62,'App\\Models\\User',4,'frontend','8c09be13e7338e63afc5392e9f5c73deb8f1167b0120ac0a712a33aa6fc219d8','[\"*\"]','2026-03-25 16:59:22',NULL,'2026-03-25 16:58:08','2026-03-25 16:59:22'),
(63,'App\\Models\\User',6,'frontend','ea9d52d627347c5f5ba5e2b75aa0ed69e83c0e0a6df9e156b7306b0625697b19','[\"*\"]','2026-03-25 17:01:06',NULL,'2026-03-25 16:59:45','2026-03-25 17:01:06'),
(64,'App\\Models\\User',6,'frontend','99b1edf182a718302f57c218db506dbca3b06bd1eae6abe7dcb90d9a1ad7d463','[\"*\"]','2026-03-25 17:05:05',NULL,'2026-03-25 17:01:40','2026-03-25 17:05:05'),
(65,'App\\Models\\User',4,'frontend','4d173175909fae440d615180d9267705e86dc8a5b7b953924bbe4aa5d4b8b2ed','[\"*\"]','2026-03-25 17:03:23',NULL,'2026-03-25 17:02:31','2026-03-25 17:03:23'),
(66,'App\\Models\\User',6,'frontend','cbf81e9aaa9c6f5934ca2fbba6197eb918c022eb44bc93f0c7a38850e4706517','[\"*\"]','2026-03-25 17:03:57',NULL,'2026-03-25 17:03:56','2026-03-25 17:03:57'),
(67,'App\\Models\\User',19,'frontend','e21e40452faddb71f4da59583d591a22de295ce00e57beeb771251e044898cb0','[\"*\"]','2026-03-25 17:04:44',NULL,'2026-03-25 17:04:29','2026-03-25 17:04:44'),
(68,'App\\Models\\User',19,'frontend','d1de2dbbef4b059cbcb7f194f6187053e39a69bf0024f1e101b85afaa4051165','[\"*\"]','2026-03-25 17:05:36',NULL,'2026-03-25 17:05:35','2026-03-25 17:05:36'),
(69,'App\\Models\\User',4,'frontend','a78daa4671262f26d729f656b11e5956bfd6af4b671ba0a64e8f96a9b2070180','[\"*\"]','2026-03-25 17:22:14',NULL,'2026-03-25 17:06:14','2026-03-25 17:22:14'),
(70,'App\\Models\\User',9,'frontend','1edbdb9a9a7ccb7d57ea96c383b6e4cad853d6da7eb978e259fa81e23b83f8de','[\"*\"]','2026-03-25 17:07:34',NULL,'2026-03-25 17:07:33','2026-03-25 17:07:34'),
(71,'App\\Models\\User',19,'frontend','0639fdc945a23aef337d89376730aa9291b4de9124265a9d7ec2ab799f8ea7ad','[\"*\"]','2026-03-25 17:22:41',NULL,'2026-03-25 17:22:41','2026-03-25 17:22:41'),
(72,'App\\Models\\User',4,'frontend','1dc0cb2b87dc14dd0f4d006afbafc5fff028d592df0bb38484c577e51b06589d','[\"*\"]','2026-03-25 17:26:18',NULL,'2026-03-25 17:23:08','2026-03-25 17:26:18'),
(73,'App\\Models\\User',19,'frontend','17d350a97b97dfdcf97089c15386b6c7afd0bc8d26197e83a798678ed51dc863','[\"*\"]','2026-03-25 17:49:55',NULL,'2026-03-25 17:49:54','2026-03-25 17:49:55'),
(74,'App\\Models\\User',4,'frontend','688b7c4b2b42c206208830cc7d83d63e28ff08be9ed6d553791637d50f0216a0','[\"*\"]','2026-03-25 17:54:27',NULL,'2026-03-25 17:54:27','2026-03-25 17:54:27'),
(75,'App\\Models\\User',4,'frontend','6b160d0eec637f15e756ee93f2e7aa8613ba351a4a4338184a0a89b21c028e57','[\"*\"]','2026-03-25 19:56:54',NULL,'2026-03-25 19:27:08','2026-03-25 19:56:54'),
(76,'App\\Models\\User',19,'frontend','4f573efec7628445182ba57b73d3adc28eba34ab7468e2bdd2116e0b57481ab4','[\"*\"]','2026-03-25 19:57:49',NULL,'2026-03-25 19:57:20','2026-03-25 19:57:49'),
(77,'App\\Models\\User',19,'frontend','09cfc141682a5a7b830b613ebf31aca2458abe51057137212c85e74dcaf3e1ca','[\"*\"]','2026-03-25 19:59:04',NULL,'2026-03-25 19:58:32','2026-03-25 19:59:04'),
(78,'App\\Models\\User',6,'frontend','529c6c64e5a761ffa64ef3e92eba900d0750e888d19eabc6f0d7140e508df1db','[\"*\"]','2026-03-25 20:00:03',NULL,'2026-03-25 19:59:35','2026-03-25 20:00:03'),
(79,'App\\Models\\User',4,'frontend','6699ddc661055cb56199c02174afdaec65ca580d44161ddde553029426966667','[\"*\"]','2026-03-25 20:01:34',NULL,'2026-03-25 20:00:32','2026-03-25 20:01:34'),
(80,'App\\Models\\User',19,'frontend','a9ab4799254d418b778165723c5651c77fdb304e80dc3c52b3fd0f9993fb9408','[\"*\"]','2026-03-25 20:02:46',NULL,'2026-03-25 20:02:45','2026-03-25 20:02:46'),
(81,'App\\Models\\User',19,'frontend','7a8559e7d6bf8273e9a6178602e7c46b1c31cbf5388d63ce7eef8fba9b92f62c','[\"*\"]','2026-03-25 20:03:48',NULL,'2026-03-25 20:03:18','2026-03-25 20:03:48'),
(82,'App\\Models\\User',19,'frontend','085d745819de51401fbe5801f3831edd31e6b4f821470a76183e2b1cbfed4274','[\"*\"]','2026-03-25 20:33:38',NULL,'2026-03-25 20:04:35','2026-03-25 20:33:38'),
(83,'App\\Models\\User',19,'frontend','45480576ac5b90fe51abe3bfecf06474f69dd07a8fa20fd3d89b986db55b6b20','[\"*\"]','2026-03-25 20:33:56',NULL,'2026-03-25 20:33:56','2026-03-25 20:33:56'),
(84,'App\\Models\\User',4,'frontend','5d5b6fec74e4423a48bf0c6b1dadfc7e7cf6bb5c6ad7bf5b312783a82274a5db','[\"*\"]','2026-03-25 21:11:00',NULL,'2026-03-25 20:34:22','2026-03-25 21:11:00'),
(85,'App\\Models\\User',20,'frontend','2db0568a41a94b8692ea516940416df97fa3d82517810740df914eeffecae08a','[\"*\"]','2026-03-25 20:52:17',NULL,'2026-03-25 20:45:44','2026-03-25 20:52:17'),
(86,'App\\Models\\User',21,'frontend','f608908b6c18ede8794da779affa946760487a243a47b1f702360d97d8325ac7','[\"*\"]','2026-03-25 21:44:22',NULL,'2026-03-25 20:48:41','2026-03-25 21:44:22'),
(87,'App\\Models\\User',20,'frontend','4e08e00b1f44dfdae80ca963b425ec299eb8333a4c3174fd7bb3e6cae6dccc81','[\"*\"]','2026-03-25 20:54:01',NULL,'2026-03-25 20:53:10','2026-03-25 20:54:01'),
(88,'App\\Models\\User',20,'frontend','c941aa52dd3ad0287352006c4bfb44581ea92acc70b125999d751c326a7f8404','[\"*\"]','2026-03-25 22:39:53',NULL,'2026-03-25 20:55:22','2026-03-25 22:39:53'),
(89,'App\\Models\\User',20,'frontend','ec8ca6f0a6e441ec1da5ca25ee813d4f1edbc3fd1f8ae34fe4eebbb4d303bc8c','[\"*\"]','2026-03-25 20:59:51',NULL,'2026-03-25 20:59:11','2026-03-25 20:59:51'),
(90,'App\\Models\\User',20,'frontend','3ec0bb54b9f4d9e1053e96c38e803f43274472939ab11ef9d9186dcf96affe45','[\"*\"]','2026-03-25 21:03:12',NULL,'2026-03-25 21:03:11','2026-03-25 21:03:12'),
(91,'App\\Models\\User',20,'frontend','44a724024d6b4917ebbeb28c51520d18179bf62919bf55749c8fec7193a00d4f','[\"*\"]','2026-03-25 21:06:13',NULL,'2026-03-25 21:06:13','2026-03-25 21:06:13'),
(92,'App\\Models\\User',20,'frontend','6981edd9219d404ac0967412853b4642e63f5b47ce8405a34a7f98f7856eae22','[\"*\"]','2026-03-25 21:08:55',NULL,'2026-03-25 21:08:17','2026-03-25 21:08:55'),
(93,'App\\Models\\User',20,'frontend','fe99e7579466c0751e1a39e9134e157f7381a1abae504f818d717511acdf92a5','[\"*\"]','2026-03-25 21:14:29',NULL,'2026-03-25 21:09:33','2026-03-25 21:14:29'),
(94,'App\\Models\\User',20,'frontend','6fdbd9a2dea44373fc8b8a2f4cf8a9bb11ddc1183f692a56adcc923fa6926dba','[\"*\"]','2026-03-25 21:10:35',NULL,'2026-03-25 21:10:35','2026-03-25 21:10:35'),
(95,'App\\Models\\User',6,'frontend','664e69dee9682c0754b12a309857a9791c5e8866948e4484c2836208c849f1ba','[\"*\"]','2026-03-25 21:13:22',NULL,'2026-03-25 21:12:31','2026-03-25 21:13:22'),
(96,'App\\Models\\User',19,'frontend','ec472b34877447628d7a6fbd5c3a50476d14bf8a863db5725139e02f7b543790','[\"*\"]','2026-03-25 21:14:13',NULL,'2026-03-25 21:13:47','2026-03-25 21:14:13'),
(97,'App\\Models\\User',20,'frontend','525f49887286084ae41ddc5510655d05a095d02ef60b3844990abe18c0286b94','[\"*\"]','2026-03-25 22:53:07',NULL,'2026-03-25 21:14:55','2026-03-25 22:53:07'),
(98,'App\\Models\\User',19,'frontend','040aeb8b7cb674866b61a2a139509fcfbe328f2b2f0802a11dfefd76119e87a7','[\"*\"]','2026-03-25 21:15:57',NULL,'2026-03-25 21:15:44','2026-03-25 21:15:57'),
(99,'App\\Models\\User',19,'frontend','9bf6758b1fef5c8782b92b9d6037289e74affd988f75d94c77d834cc627dd660','[\"*\"]','2026-03-25 21:16:28',NULL,'2026-03-25 21:16:20','2026-03-25 21:16:28'),
(100,'App\\Models\\User',4,'frontend','bf763ab1913ffe23cbf36d883fe4e1b4b7d8983e83f709737c2941d2232fb1c9','[\"*\"]','2026-03-25 21:24:55',NULL,'2026-03-25 21:17:06','2026-03-25 21:24:55'),
(101,'App\\Models\\User',20,'frontend','5d520f065bb274d1e10d460212666e4922eb7fd5cb0e8895af52510664f39563','[\"*\"]','2026-03-25 21:25:51',NULL,'2026-03-25 21:24:23','2026-03-25 21:25:51'),
(102,'App\\Models\\User',19,'frontend','ff54ceb7f6e007440e98cb806381ae34564978378eee93fb9cd0fecc83a5016b','[\"*\"]','2026-03-25 21:26:33',NULL,'2026-03-25 21:26:33','2026-03-25 21:26:33'),
(103,'App\\Models\\User',19,'frontend','32226bc41b8d125e2067445533e2a00b49435ecc34a748f707365d823c78d92b','[\"*\"]','2026-03-25 21:27:32',NULL,'2026-03-25 21:27:00','2026-03-25 21:27:32'),
(104,'App\\Models\\User',4,'frontend','b414a7bc5650c3d50977b012036d8b9ace5ca85b5a59f1730ac5b7fa3b023750','[\"*\"]','2026-03-25 21:27:50',NULL,'2026-03-25 21:27:50','2026-03-25 21:27:50'),
(105,'App\\Models\\User',20,'frontend','a777ec8b4a98ce3f87044b1ac132482952e439981c5ced8de9eca31dfce7977a','[\"*\"]','2026-03-25 22:16:46',NULL,'2026-03-25 21:27:52','2026-03-25 22:16:46'),
(106,'App\\Models\\User',6,'frontend','fba40d55621b8099c7c242593370dc2b7a569b3f74566b1a299d976ca60488f0','[\"*\"]','2026-03-25 21:28:48',NULL,'2026-03-25 21:28:17','2026-03-25 21:28:48'),
(107,'App\\Models\\User',4,'frontend','d58f059240434582ab08e9bb5b29084ae9f0f396699270bc9f115f1b5db64a81','[\"*\"]','2026-03-25 21:35:39',NULL,'2026-03-25 21:29:01','2026-03-25 21:35:39'),
(108,'App\\Models\\User',4,'frontend','8f076c356fa199f00be0d45d3e7c898cd62faaa6011a4c700d9d8ba3ec66cdc9','[\"*\"]','2026-03-25 22:23:08',NULL,'2026-03-25 21:45:16','2026-03-25 22:23:08'),
(109,'App\\Models\\User',20,'frontend','d4727b19bdda9607939b71dae2bc9aea9b9606d40b0b42c5c2ef3402af34a889','[\"*\"]','2026-03-25 22:12:39',NULL,'2026-03-25 22:12:20','2026-03-25 22:12:39'),
(110,'App\\Models\\User',20,'frontend','495b312528bac9b5e3833cad650139d5374b393e099209b976e26fd22d42feba','[\"*\"]','2026-03-26 06:47:12',NULL,'2026-03-25 22:12:54','2026-03-26 06:47:12'),
(111,'App\\Models\\User',20,'frontend','1c79497c87312b1676117d59de843f5014ff673d192023b3984760df40d6ebbe','[\"*\"]','2026-03-25 22:19:05',NULL,'2026-03-25 22:19:04','2026-03-25 22:19:05'),
(112,'App\\Models\\User',20,'frontend','c559cdb1d1a5452ad901d549550b4d6cacf20c454379a77e8a382490512b1dea','[\"*\"]','2026-03-25 23:02:55',NULL,'2026-03-25 22:40:37','2026-03-25 23:02:55'),
(113,'App\\Models\\User',20,'frontend','f399aec18b01e78582925d00c2ee578ebb547f127a0160743d33d668d2fd0d39','[\"*\"]','2026-03-25 22:57:30',NULL,'2026-03-25 22:55:22','2026-03-25 22:57:30'),
(114,'App\\Models\\User',20,'frontend','58a198e85489cdb17f3a02b832b7ff24929d10eab1b6456dc1931688e238a730','[\"*\"]','2026-03-25 22:58:04',NULL,'2026-03-25 22:57:57','2026-03-25 22:58:04'),
(115,'App\\Models\\User',20,'frontend','0997a1ac99bddc31eda83d2e36dbdb17eb7a5a94f717a29db20c46ab7c4296ea','[\"*\"]','2026-03-26 01:23:40',NULL,'2026-03-25 23:01:58','2026-03-26 01:23:40'),
(116,'App\\Models\\User',20,'frontend','c03fdf63628d693022689929b95e8d7ba23fa2825ea6ddeb13e492d3285ed394','[\"*\"]','2026-03-25 23:03:52',NULL,'2026-03-25 23:03:41','2026-03-25 23:03:52'),
(117,'App\\Models\\User',20,'frontend','1c8e44218dcbad47faf11de9c219b3236b68475023c95e3b1a25058eca90a3ed','[\"*\"]','2026-03-25 23:08:42',NULL,'2026-03-25 23:08:35','2026-03-25 23:08:42'),
(118,'App\\Models\\User',4,'frontend','2ba06047ab05dfeda0b8c6ae38578e3ea45c5beb2848c7976292eebed064a051','[\"*\"]','2026-03-26 01:39:23',NULL,'2026-03-25 23:15:55','2026-03-26 01:39:23'),
(119,'App\\Models\\User',19,'frontend','74aa30a4e0954f09d4cdf9fc3b8f5826cf881852ed5cf3e02dbc3ae5bfd119d5','[\"*\"]','2026-03-26 01:39:44',NULL,'2026-03-26 01:39:42','2026-03-26 01:39:44'),
(120,'App\\Models\\User',4,'frontend','a5629d99f90bad701bbd324dacabc045e5410df230a1a78fd2a4523d7e6c7904','[\"*\"]','2026-03-26 01:40:33',NULL,'2026-03-26 01:40:14','2026-03-26 01:40:33'),
(121,'App\\Models\\User',6,'frontend','b69d22d57ffc80658b9bd780ad7de0085a12b3ec3a0ed42b5536a17e194fdf54','[\"*\"]','2026-03-26 01:51:19',NULL,'2026-03-26 01:40:58','2026-03-26 01:51:19'),
(122,'App\\Models\\User',4,'frontend','36c95e63fb8e80f39ad89ec88a439b9c452fa8a1d88a19544c980601c9c54aac','[\"*\"]','2026-03-26 03:05:42',NULL,'2026-03-26 03:05:38','2026-03-26 03:05:42'),
(123,'App\\Models\\User',19,'frontend','526d26cd4845cd8c00bfe208a97646160f823534d670f13da5e615f3782654cb','[\"*\"]','2026-03-26 03:37:21',NULL,'2026-03-26 03:34:19','2026-03-26 03:37:21'),
(124,'App\\Models\\User',4,'frontend','51f955794c917e035d0d99b76483e74b51339e20dc522369bd43326b82955921','[\"*\"]','2026-03-26 07:48:28',NULL,'2026-03-26 03:47:11','2026-03-26 07:48:28'),
(125,'App\\Models\\User',19,'frontend','6bea271f3bf51eb8a0fff6cf5fbe18c891ea5161641e73687dbfe47271a10e46','[\"*\"]','2026-03-26 08:41:31',NULL,'2026-03-26 08:40:29','2026-03-26 08:41:31'),
(126,'App\\Models\\User',19,'frontend','4ec7b6a857a1fbf842ada5aa64e28545bb647a97410bdca1818eea96a4e114f8','[\"*\"]','2026-03-26 08:42:15',NULL,'2026-03-26 08:42:13','2026-03-26 08:42:15'),
(127,'App\\Models\\User',4,'frontend','e5b7dbf2b8f6a40a17d427a9494756e88234ab67992e15cfd52b53b4be583661','[\"*\"]','2026-03-26 09:16:15',NULL,'2026-03-26 08:44:46','2026-03-26 09:16:15'),
(128,'App\\Models\\User',4,'frontend','5de3eeeecebdb46e2c5d28d96b9eebc6354ef0e1b480394e454498fed9578921','[\"*\"]','2026-03-26 09:32:10',NULL,'2026-03-26 09:16:34','2026-03-26 09:32:10'),
(129,'App\\Models\\User',4,'frontend','3b83c295f540b8ae93052161376774f23b0ea6a103d40e562431ee9e51050499','[\"*\"]','2026-03-26 09:32:28',NULL,'2026-03-26 09:32:27','2026-03-26 09:32:28'),
(130,'App\\Models\\User',4,'frontend','4e43caab18a4b2b191fbc39e2565123b759ea8b56c8d3aba6c1f3649e71ce230','[\"*\"]','2026-03-26 09:41:13',NULL,'2026-03-26 09:34:00','2026-03-26 09:41:13'),
(131,'App\\Models\\User',4,'frontend','676a30bc0a5a4b9015c2eb30f0e659528ca08dbc130bf557ff06762a7f7c6327','[\"*\"]','2026-03-26 19:52:27',NULL,'2026-03-26 19:36:34','2026-03-26 19:52:27'),
(132,'App\\Models\\User',4,'frontend','1026d3a65b43c89ca50c84428cf13313e2aa21f4af801b1e8c5341bee1bf9a65','[\"*\"]','2026-03-27 09:46:38',NULL,'2026-03-27 09:34:10','2026-03-27 09:46:38'),
(133,'App\\Models\\User',19,'frontend','f03b03b18a85112f334b646fe9b2126defe68f870dead0f43489dc673b3ab807','[\"*\"]','2026-03-27 10:08:54',NULL,'2026-03-27 09:47:12','2026-03-27 10:08:54'),
(134,'App\\Models\\User',19,'frontend','bd8636dd96243c1f423da8e83709cc6d00d7aff995ff9aabae4121bb1c54d82c','[\"*\"]','2026-03-27 22:09:13',NULL,'2026-03-27 20:04:39','2026-03-27 22:09:13'),
(135,'App\\Models\\User',4,'frontend','2017f30ff276dc1848da923f2a465e6457b64851d72d6b4248ffbe21f9e0f844','[\"*\"]','2026-03-27 20:08:47',NULL,'2026-03-27 20:05:17','2026-03-27 20:08:47'),
(136,'App\\Models\\User',4,'frontend','987c1f9a6bb907f2468da5469a4a9fca213101efd0879eb12b9c831efb505fd2','[\"*\"]','2026-03-27 22:40:43',NULL,'2026-03-27 20:10:16','2026-03-27 22:40:43'),
(137,'App\\Models\\User',19,'frontend','9cda537d73371a9f8be8247b58d019c995c67387d651d5741a095b8cad7a5368','[\"*\"]','2026-03-28 00:16:43',NULL,'2026-03-27 22:21:22','2026-03-28 00:16:43'),
(138,'App\\Models\\User',4,'frontend','6a9709094577b0bff3034f0b2b2a4b25a7ac8edfcd76c3f6eb1937fbbe3ee94d','[\"*\"]','2026-03-28 00:19:56',NULL,'2026-03-27 22:41:11','2026-03-28 00:19:56'),
(139,'App\\Models\\User',6,'frontend','e1f473d45446a8d80753b654da48c17b56685ec5e5f4cef33055245cac85c101','[\"*\"]','2026-03-28 01:06:54',NULL,'2026-03-28 00:17:11','2026-03-28 01:06:54'),
(140,'App\\Models\\User',19,'frontend','8e077633935b269612d70f6e92eb52d5c526e44bd8555ea3db97c28eb354340c','[\"*\"]','2026-03-28 00:20:32',NULL,'2026-03-28 00:20:27','2026-03-28 00:20:32'),
(141,'App\\Models\\User',9,'frontend','999e63bd4e6ed9ba2d91e4f8ebcce26059d3a33c379774b6c163176de17a3800','[\"*\"]','2026-03-28 00:21:45',NULL,'2026-03-28 00:21:28','2026-03-28 00:21:45'),
(142,'App\\Models\\User',19,'frontend','a33cd3220c04c97aa455ec4ac7e4a2d28e98286003f761e48dfe585779a5e133','[\"*\"]','2026-03-28 00:22:25',NULL,'2026-03-28 00:22:20','2026-03-28 00:22:25'),
(143,'App\\Models\\User',4,'frontend','16776d94f20166e8b020c6e40df4a029f12b36c03327a34a0b7f42b8819b9c57','[\"*\"]','2026-03-28 00:24:51',NULL,'2026-03-28 00:22:53','2026-03-28 00:24:51'),
(144,'App\\Models\\User',23,'frontend','8064286edfe2174ffea20016d30440031b6e7183d1c21435e5e0d712e031a2f8','[\"*\"]','2026-03-28 00:26:52',NULL,'2026-03-28 00:25:04','2026-03-28 00:26:52'),
(145,'App\\Models\\User',4,'frontend','d100a59125a8056f7e678c47b75b0640169e2c6070cd612435a21cb7c8d6ae1d','[\"*\"]','2026-03-28 01:09:29',NULL,'2026-03-28 00:33:36','2026-03-28 01:09:29'),
(146,'App\\Models\\User',6,'frontend','fec89923212fe0b815ee6dc3161dec76b6d6b0cfe566729696b3aacac44dc31c','[\"*\"]','2026-03-28 05:08:53',NULL,'2026-03-28 01:07:25','2026-03-28 05:08:53'),
(147,'App\\Models\\User',4,'frontend','3ff0f1c359a3fd1d5bfa19b70cea94acc238dd82c296bfa7fd9615ad06658d24','[\"*\"]','2026-03-28 01:38:22',NULL,'2026-03-28 01:11:18','2026-03-28 01:38:22'),
(148,'App\\Models\\User',4,'frontend','aa5a2581e21791e14e2ed57136c61b2703a510791702eb66ab5d39098e08160e','[\"*\"]','2026-03-28 01:39:41',NULL,'2026-03-28 01:39:15','2026-03-28 01:39:41'),
(149,'App\\Models\\User',23,'frontend','9ef710a508abdb66177b600d8ac73557cc6d72fa30e8eb45559b2be4048e2b03','[\"*\"]','2026-03-28 01:40:16',NULL,'2026-03-28 01:40:15','2026-03-28 01:40:16'),
(150,'App\\Models\\User',4,'frontend','ebcc41620beca7a7f4f9083585cc735e2ef8ccfb55c4ff2f55396b44a1b72b30','[\"*\"]','2026-03-28 01:40:55',NULL,'2026-03-28 01:40:30','2026-03-28 01:40:55'),
(151,'App\\Models\\User',23,'frontend','3e17d5636550ac9c534a55d044771ff4338c1847542915b0d212baf4071a70d1','[\"*\"]','2026-03-28 01:49:09',NULL,'2026-03-28 01:41:25','2026-03-28 01:49:09'),
(152,'App\\Models\\User',4,'frontend','45051a7d35c4dc5e9eb54690c817aece61472ea7e875af5ba31ba63e89cb6887','[\"*\"]','2026-03-28 02:02:19',NULL,'2026-03-28 02:01:51','2026-03-28 02:02:19'),
(153,'App\\Models\\User',4,'frontend','b059edbde8a37a47859b58a8bd63c57a19772b9940fcdebdf03d14ed02f05ef4','[\"*\"]','2026-03-28 02:03:50',NULL,'2026-03-28 02:03:05','2026-03-28 02:03:50'),
(154,'App\\Models\\User',23,'frontend','af62d51a0a0a4682e33720dbb4d81072af07a6fd4e99c23b4e4ee0496e474931','[\"*\"]','2026-03-28 02:04:16',NULL,'2026-03-28 02:04:15','2026-03-28 02:04:16'),
(155,'App\\Models\\User',23,'frontend','62ebf05d0cc9e0fb1222bf3ae3d300996218478a9d521df7222e842b08abb58a','[\"*\"]','2026-03-28 02:05:03',NULL,'2026-03-28 02:04:33','2026-03-28 02:05:03'),
(156,'App\\Models\\User',23,'frontend','4442df86ac56a60e6b7d6a64d55209ed134b00481e84515cd377a8591cfb615a','[\"*\"]','2026-03-28 02:10:05',NULL,'2026-03-28 02:05:32','2026-03-28 02:10:05'),
(157,'App\\Models\\User',4,'frontend','a7a729d1c4b7964799010dc01436f04e6fd56bcc3a9554929dcdbc65d77f486d','[\"*\"]','2026-03-28 02:19:34',NULL,'2026-03-28 02:11:50','2026-03-28 02:19:34'),
(158,'App\\Models\\User',4,'frontend','58eceec755a556c07e766c5faed0b924c611c61d7371f8de2bbf1929bb1367ce','[\"*\"]','2026-03-28 05:05:55',NULL,'2026-03-28 03:19:28','2026-03-28 05:05:55'),
(159,'App\\Models\\User',22,'frontend','610edcb77098d87924195f412df50bad9dee2869bca64a3522069d123ac3e210','[\"*\"]','2026-03-28 05:02:58',NULL,'2026-03-28 03:23:25','2026-03-28 05:02:58'),
(160,'App\\Models\\User',22,'frontend','42c7924f53b9f70e9bfa39ee370b574a657f2553d4fce2a4593811dad4d250a8','[\"*\"]','2026-03-30 18:39:16',NULL,'2026-03-28 05:03:18','2026-03-30 18:39:16'),
(161,'App\\Models\\User',4,'frontend','114a4cc65f9a64ad794a88fbf41b95ec3ef361b9e1ca88ccb565918702819a25','[\"*\"]','2026-03-28 19:30:36',NULL,'2026-03-28 05:06:27','2026-03-28 19:30:36'),
(162,'App\\Models\\User',6,'frontend','444b04afefcc516070c3bf1cbb4afc7ac9a810ad2d5a066a7048776cfa5d0849','[\"*\"]','2026-03-28 05:10:01',NULL,'2026-03-28 05:09:18','2026-03-28 05:10:01'),
(163,'App\\Models\\User',6,'frontend','e0cfd7672fc2d5b857173de4dbfb7deb0c5c5088f447c36b14f1a1ca28178032','[\"*\"]','2026-03-28 05:12:38',NULL,'2026-03-28 05:10:34','2026-03-28 05:12:38'),
(164,'App\\Models\\User',6,'frontend','8e630ffb330d0b76312fea2b399ee510e9e10056eb7da9790c2702cd16cc56ca','[\"*\"]','2026-03-28 19:29:57',NULL,'2026-03-28 05:13:10','2026-03-28 19:29:57'),
(165,'App\\Models\\User',24,'frontend','950ad6dfc2287486eae6ea3c2729789e8295851887e13005445eb591f2fc1b2f','[\"*\"]','2026-03-29 02:05:11',NULL,'2026-03-28 19:55:14','2026-03-29 02:05:11'),
(166,'App\\Models\\User',25,'frontend','0b1226acfa046b1ebb1402676542951ae9bb65c11ad881c717788ce62321aea8','[\"*\"]','2026-03-28 20:02:54',NULL,'2026-03-28 19:59:37','2026-03-28 20:02:54'),
(167,'App\\Models\\User',23,'frontend','cfc0ac6cba78a0da02fab691087f4caf9b9ff1227163de58a99b45f6ade85e19','[\"*\"]','2026-03-29 01:20:06',NULL,'2026-03-29 01:05:17','2026-03-29 01:20:06'),
(168,'App\\Models\\User',4,'frontend','8d2222b18904e30ca9fd5412979089dcb1148f934eaf46b4c5e8e68f9ad0fc9c','[\"*\"]','2026-03-29 02:05:52',NULL,'2026-03-29 02:05:48','2026-03-29 02:05:52'),
(169,'App\\Models\\User',23,'frontend','2a490d88f9a5bfc1fd32ccde9f837b9bfe6abff710577e992a4e68e3f8c3997d','[\"*\"]','2026-03-29 02:06:09',NULL,'2026-03-29 02:06:08','2026-03-29 02:06:09'),
(170,'App\\Models\\User',24,'frontend','ea59a2a69f4b8fd927e11881c7f1ab14c897b2598c2dfd6b35f7e9cb945d2151','[\"*\"]','2026-03-30 09:19:01',NULL,'2026-03-29 02:07:28','2026-03-30 09:19:01'),
(171,'App\\Models\\User',26,'frontend','e6e14bc2ebbc58fbc3b95a87f9096c7846cddb444eb3b932271f543ad3b30be3','[\"*\"]','2026-04-02 05:39:09',NULL,'2026-03-29 02:08:02','2026-04-02 05:39:09'),
(172,'App\\Models\\User',19,'frontend','96657e14746c717945642d27a4a03dbc4c76286ed1840bedb8714350e27a71a2','[\"*\"]','2026-04-03 21:17:37',NULL,'2026-04-02 05:40:24','2026-04-03 21:17:37'),
(173,'App\\Models\\User',4,'frontend','bf11796e2243f3edb0bb939d5a2820ac705cd64d43829ecdc1648855d878afb5','[\"*\"]','2026-04-03 22:01:30',NULL,'2026-04-03 21:58:54','2026-04-03 22:01:30'),
(174,'App\\Models\\User',27,'frontend','f29d9ea881422117b735c398eafd0effe385c699d986158ae30359708ec44f59','[\"*\"]','2026-04-03 22:03:59',NULL,'2026-04-03 22:03:08','2026-04-03 22:03:59'),
(175,'App\\Models\\User',27,'frontend','c31ade213114ffced0ab16ee65e80162c8f83c3e30a092acce3fbf1f5c2381d4','[\"*\"]','2026-04-03 22:04:39',NULL,'2026-04-03 22:04:16','2026-04-03 22:04:39'),
(176,'App\\Models\\User',27,'frontend','df0559520f5e9f6c2d5196d5ab6bfc523abc506f3dab5bee78aa29f940bcbfb8','[\"*\"]','2026-04-03 22:05:30',NULL,'2026-04-03 22:05:30','2026-04-03 22:05:30'),
(177,'App\\Models\\User',4,'frontend','ce36dbae914d2561577d3999d1c6f86309016f69a5cb26471b4cae98cb0bef28','[\"*\"]','2026-04-03 22:07:27',NULL,'2026-04-03 22:06:36','2026-04-03 22:07:27'),
(178,'App\\Models\\User',4,'frontend','c9f53cd6b29db63130c5e1042362bdd158b19eeb30911709c30f34a81bd4c01a','[\"*\"]','2026-04-03 22:29:34',NULL,'2026-04-03 22:29:33','2026-04-03 22:29:34'),
(179,'App\\Models\\User',4,'frontend','f78c72f1de1c9d87f5d31edc198758b9eda08edcdf481f2e4a4eebb85fe87c98','[\"*\"]','2026-04-03 22:30:58',NULL,'2026-04-03 22:30:54','2026-04-03 22:30:58');
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
  `etiqueta` varchar(255) NOT NULL,
  `ciudad_estado` varchar(180) NOT NULL,
  `zona` varchar(25) NOT NULL,
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
  KEY `idx_propiedades_etiqueta` (`etiqueta`),
  KEY `idx_propiedades_id_agente` (`id_agente`),
  KEY `idx_propiedades_propietario` (`propietario`),
  CONSTRAINT `fk_propiedades_agentes` FOREIGN KEY (`id_agente`) REFERENCES `agentes` (`id_agente`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `propiedades`
--

LOCK TABLES `propiedades` WRITE;
/*!40000 ALTER TABLE `propiedades` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `propiedades` VALUES
(1,'PUB-0001','Residencias El Bosque','Residencias El Bosque','Valencia, Carabobo','','Apartamento',125000.00,'disponible','publicado','Apartamento en excelente zona, cerca de centros comerciales.','{\"dormitorios\":3,\"banos\":2,\"area_m2\":110,\"estacionamientos\":2,\"con_piscina\":true,\"pet_friendly\":true,\"ano_construccion\":2018,\"amoblada\":false,\"balcon\":true,\"seguridad_privada\":true,\"financiable\":true}',11,6,10.1620000,-68.0077000,'https://mi-cdn.com/propiedades/p-1-main.jpg','[\"https://mi-cdn.com/propiedades/p-1-2.jpg\",\"https://mi-cdn.com/propiedades/p-1-3.jpg\"]'),
(2,'PUB-0002','Casa Los Naranjos','Casa Los Naranjos','Caracas, Distrito Capital','','Casa',185000.00,'disponible','publicado','Casa de dos niveles, remodelada, con buena ventilacion.','{\"dormitorios\":4,\"banos\":3,\"area_m2\":220,\"estacionamientos\":2,\"con_piscina\":false,\"pet_friendly\":true,\"ano_construccion\":2012,\"amoblada\":false,\"balcon\":true,\"seguridad_privada\":true,\"financiable\":true}',11,7,10.4806000,-66.9036000,'https://mi-cdn.com/propiedades/p-2-main.jpg','[\"https://mi-cdn.com/propiedades/p-2-2.jpg\",\"https://mi-cdn.com/propiedades/p-2-3.jpg\"]'),
(3,'PUB-0003','Yonaj','En venta','Caracas','','Apartamento',12500.00,'disponible','publicado','Holas','{\"dormitorios\":0,\"banos\":0,\"area_m2\":0,\"estacionamientos\":0,\"con_piscina\":false,\"pet_friendly\":false,\"ano_construccion\":2026,\"amoblada\":false,\"balcon\":false,\"seguridad_privada\":true,\"financiable\":false}',6,4,10.5060930,-66.9146010,'propiedades/r1CDmlebBjkaYed0wo5e0T3wjvCLzNGSW5AZAbim.png','[\"propiedades\\/cZ9FmtlTvtA9ZgWqTkdF5c1l7jqYISda4NJdueKc.jpg\"]'),
(4,'PUB-0004','Casa prueba','En venta','Carabobo','','Apartamento',13000.00,'disponible','publicado','Casa moderna','{\"dormitorios\":3,\"banos\":3,\"area_m2\":200,\"estacionamientos\":2,\"con_piscina\":false,\"pet_friendly\":false,\"ano_construccion\":2026,\"amoblada\":false,\"balcon\":false,\"seguridad_privada\":true,\"financiable\":false}',6,NULL,10.1700260,-68.0003990,'propiedades/Tnwn6JDAajJTNKlgMsEVV08YxQKnmnNkjXKbaray.png','[\"propiedades\\/EbcpgCJUrSHsyH6Owq9SCkRpIOijlTJwrCkIqw1T.jpg\"]'),
(5,'PUB-0005','Casssa','En venta','Cagua','','Casa',12000.00,'disponible','publicado','Casa preciosa','{\"dormitorios\":2,\"banos\":2,\"area_m2\":200,\"estacionamientos\":2,\"con_piscina\":false,\"pet_friendly\":false,\"ano_construccion\":2026,\"amoblada\":false,\"balcon\":false,\"seguridad_privada\":true,\"financiable\":false}',19,NULL,10.1796630,-67.4606770,'propiedades/flcuWQUcm8F8YcF0tPKFQfRtqtAa36TtVN2KjX3l.jpg','[\"propiedades\\/26X4ABjOGHxvf22qDrdCDcrkkpT2GccvkoMZUs3H.png\"]'),
(6,'PUB-0006','Casa preciosa','En venta','Maracay','','Apartamento',20000.00,'disponible','publicado','Casa en venta','{\"dormitorios\":5,\"banos\":2,\"area_m2\":300,\"estacionamientos\":2,\"con_piscina\":false,\"pet_friendly\":false,\"ano_construccion\":2026,\"amoblada\":false,\"balcon\":false,\"seguridad_privada\":true,\"financiable\":false}',19,14,10.2624930,-67.5914280,'propiedades/N6pfCDaNsRNJQc6B6gxvoRET7rzFkJW9mO06us0J.jpg','[\"propiedades\\/f2ePAC0w7Fa60uDZlgJWe8Up6yEXEcTtDXZvCED0.jpg\"]'),
(7,'PUB-0007','Casa 2','En venta','Maracay','','Apartamento',30000.00,'disponible','publicado','Casa en Maracay','{\"dormitorios\":2,\"banos\":2,\"area_m2\":200,\"estacionamientos\":1,\"con_piscina\":false,\"pet_friendly\":false,\"ano_construccion\":2026,\"amoblada\":false,\"balcon\":false,\"seguridad_privada\":true,\"financiable\":false}',19,NULL,10.2398190,-67.5920240,'propiedades/pXXCpugzxQ15ImalluvRklzkAA1VLjVAR2ZQUx12.jpg','[\"propiedades\\/JXQyUjHM9hlAUkD31QroY2N0xGzPqegyB0VfnGHX.jpg\"]'),
(8,'PUB-0008','casa 3','En venta','Maracay','','Apartamento',300000.00,'disponible','publicado','Casa 3','{\"dormitorios\":0,\"banos\":0,\"area_m2\":0,\"estacionamientos\":0,\"con_piscina\":false,\"pet_friendly\":false,\"ano_construccion\":2026,\"amoblada\":false,\"balcon\":false,\"seguridad_privada\":true,\"financiable\":false}',19,NULL,10.2547220,-67.5673770,'propiedades/QcTCwFzNMrVf65ryXLObvptZAsu9UiPCeYs6zA8p.jpg','[]'),
(9,'PUB-0009','Linda casa 5','En venta','Maracay','','Apartamento',300000.00,'disponible','publicado','Casa prueba 4','{\"dormitorios\":2,\"banos\":2,\"area_m2\":300,\"estacionamientos\":2,\"con_piscina\":false,\"pet_friendly\":false,\"ano_construccion\":2026,\"amoblada\":false,\"balcon\":false,\"seguridad_privada\":true,\"financiable\":false}',19,NULL,10.2708050,-67.6300010,'propiedades/kaIWbOxelRX6f0yYMrmo32cmvH5iAbpaTzlFWA0e.jpg','[\"propiedades\\/7iUj3pNEztNc2Gnu6gL5veC9hXPzkXauzcPHrlcW.jpg\"]'),
(10,'PUB-0010','Casa 5','En venta','Maracay','','Apartamento',2000.00,'disponible','publicado','Casa linda en Maracay','{\"dormitorios\":2,\"banos\":2,\"area_m2\":200,\"estacionamientos\":2,\"con_piscina\":false,\"pet_friendly\":false,\"ano_construccion\":2026,\"amoblada\":false,\"balcon\":false,\"seguridad_privada\":true,\"financiable\":false}',19,14,10.2422210,-67.5699970,'propiedades/1jF2CKhRs1cesMHo33WKtf6YyxrkLuezPlWOeF8O.jpg','[\"propiedades\\/ps9pYKE1vGmBMWzmEIdtRNT9fvEqLepXlkrF3XnQ.jpg\"]'),
(11,'PUB-0011','Casita','En venta','Cagua','las vegas','Apartamento',200000.00,'disponible','publicado','Casita en cagua','{\"dormitorios\":2,\"banos\":2,\"area_m2\":200,\"estacionamientos\":2,\"con_piscina\":false,\"pet_friendly\":false,\"ano_construccion\":2026,\"amoblada\":false,\"balcon\":false,\"seguridad_privada\":true,\"financiable\":false}',19,NULL,10.1628120,-67.4449910,'propiedades/3fubE8zxHaJt74CCux5EqbcTqwFkGK1uwflSVxKU.jpg','[\"propiedades\\/X0wnVz7MA57ZWrdAXBUPCHrbVKpkNO8nxVFIMKqd.jpg\"]'),
(12,'PUB-0012','prueba cierre','cierre','Caracas','altamira','Apartamento',20000.00,'disponible','publicado','cierre','{\"dormitorios\":2,\"banos\":2,\"area_m2\":200,\"estacionamientos\":2,\"con_piscina\":false,\"pet_friendly\":false,\"ano_construccion\":2026,\"amoblada\":false,\"balcon\":false,\"seguridad_privada\":true,\"financiable\":false}',25,NULL,10.4955890,-66.8488590,'propiedades/lB7aVD2njpgeesVjq3UunypphFlSV6KyQGHRD0Hm.png','[\"propiedades\\/mwPupZUXXIvdLLsO1xnI2RC1xr9ieKaEzcOsvNRg.png\"]'),
(13,'PUB-0013','casa muffin','muffin','Villa de cura','cementerio','Apartamento',30000.00,'disponible','publicado','muffin house','{\"dormitorios\":2,\"banos\":2,\"area_m2\":200,\"estacionamientos\":2,\"con_piscina\":false,\"pet_friendly\":false,\"ano_construccion\":2026,\"amoblada\":false,\"balcon\":false,\"seguridad_privada\":true,\"financiable\":false}',26,NULL,10.0348150,-67.4948840,'propiedades/X6ik8U6GDvc47tffLXj4GDuMmO18VIz1wQGnE9mV.jpg','[\"propiedades\\/9pTs3WUkoXkrMUS48qtZWrWuG6GhJcLFIsmADfAP.jpg\"]');
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
  `ref` int(11) DEFAULT NULL,
  `estado` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_publicar_ciudad_zona` (`ciudad`,`zona`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publicar_ins`
--

LOCK TABLES `publicar_ins` WRITE;
/*!40000 ALTER TABLE `publicar_ins` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `publicar_ins` VALUES
(1,'Yonnel','04129168395','Maracay','Casa','Casa','publicar-in/KDonuP1KOoOSeHHO2qy2EuOt7Xmc6oJ8ujmaR5fW.jpg','Casa',0,NULL),
(2,'Yonn','04124512048','Caracas','altamira','Casa','publicar-in/ugWHh3MiZ3vQieir6BGc7Mvedm1I43GAjN1ffLPf.jpg','Casa',8,NULL),
(3,'Juanito','20145415255','mariara','mariara','casa','publicar-in/gbeDYGvz1ttP73NxmxVBRn5EsJzBTVVbmRRuNN51.jpg','Casa para perros',6,NULL),
(4,'sjasd','04125465556','Los teques','la arboleda','casa','publicar-in/JAkAljMnZubTqXf9IoPsvcAIjwpvJWuxpHaQ19mO.png','casa',25,NULL);
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
  `user_id` bigint(20) unsigned DEFAULT NULL,
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
  KEY `idx_push_notifications_loan` (`loan_id`),
  KEY `idx_push_notifications_user` (`user_id`),
  CONSTRAINT `fk_push_notifications_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=155 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `push_notifications`
--

LOCK TABLES `push_notifications` WRITE;
/*!40000 ALTER TABLE `push_notifications` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `push_notifications` VALUES
(83,20,29,163,'due_hourly','2026-03-25',19,'user:20:cut:163:due_hourly:2026-03-25:19','Corte con vencimiento hoy','prueba: hoy vence tu corte de 1200.00.','https://smarthouse-ve.com/jrplks/?view=history&loanId=29&cutId=163','loan-due-today-cut-163-h19','2026-03-25 19:00:00','sent',1,0,0,0,'2026-03-25 19:00:01',NULL,'2026-03-25 23:00:01','2026-03-25 23:00:01'),
(84,20,29,163,'due_hourly','2026-03-25',20,'user:20:cut:163:due_hourly:2026-03-25:20','Corte con vencimiento hoy','prueba: hoy vence tu corte de 1200.00.','https://smarthouse-ve.com/jrplks/?view=history&loanId=29&cutId=163','loan-due-today-cut-163-h20','2026-03-25 20:00:00','sent',1,3,2,1,'2026-03-25 20:00:01',NULL,'2026-03-26 00:00:01','2026-03-26 00:00:01'),
(85,20,29,163,'due_hourly','2026-03-25',21,'user:20:cut:163:due_hourly:2026-03-25:21','Corte con vencimiento hoy','prueba: hoy vence tu corte de 1200.00.','https://smarthouse-ve.com/jrplks/?view=history&loanId=29&cutId=163','loan-due-today-cut-163-h21','2026-03-25 21:00:00','sent',1,2,2,0,'2026-03-25 21:00:01',NULL,'2026-03-26 01:00:01','2026-03-26 01:00:02'),
(86,20,29,163,'due_hourly','2026-03-25',22,'user:20:cut:163:due_hourly:2026-03-25:22','Corte con vencimiento hoy','prueba: hoy vence tu corte de 1200.00.','https://smarthouse-ve.com/jrplks/?view=history&loanId=29&cutId=163','loan-due-today-cut-163-h22','2026-03-25 22:00:00','sent',1,2,2,0,'2026-03-25 22:00:02',NULL,'2026-03-26 02:00:02','2026-03-26 02:00:02'),
(87,20,29,163,'due_hourly','2026-03-25',23,'user:20:cut:163:due_hourly:2026-03-25:23','Corte con vencimiento hoy','prueba: hoy vence tu corte de 1200.00.','https://smarthouse-ve.com/jrplks/?view=history&loanId=29&cutId=163','loan-due-today-cut-163-h23','2026-03-25 23:00:00','sent',1,2,2,0,'2026-03-25 23:00:02',NULL,'2026-03-26 03:00:02','2026-03-26 03:00:02'),
(88,17,24,93,'due_hourly','2026-04-01',0,'user:17:cut:93:due_hourly:2026-04-01:00','Corte con vencimiento hoy','Adrián Proautos: hoy vence tu corte de 500.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=24&cutId=93','loan-due-today-cut-93-h00','2026-04-01 00:00:00','sent',1,1,1,0,'2026-04-01 00:00:04',NULL,'2026-04-01 04:00:02','2026-04-01 04:00:09'),
(89,18,32,174,'due_hourly','2026-04-01',0,'user:18:cut:174:due_hourly:2026-04-01:00','Corte con vencimiento hoy','Deliplaza: hoy vence tu corte de 18090.00.','https://smarthouse-ve.com/Z4rwKp771903/?view=history&loanId=32&cutId=174','loan-due-today-cut-174-h00','2026-04-01 00:00:20','sent',1,1,1,0,'2026-04-01 00:01:01',NULL,'2026-04-01 04:00:03','2026-04-01 04:01:01'),
(90,17,24,93,'due_hourly','2026-04-01',1,'user:17:cut:93:due_hourly:2026-04-01:01','Corte con vencimiento hoy','Adrián Proautos: hoy vence tu corte de 500.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=24&cutId=93','loan-due-today-cut-93-h01','2026-04-01 01:00:00','sent',1,1,1,0,'2026-04-01 01:00:01',NULL,'2026-04-01 05:00:01','2026-04-01 05:00:02'),
(91,18,32,174,'due_hourly','2026-04-01',1,'user:18:cut:174:due_hourly:2026-04-01:01','Corte con vencimiento hoy','Deliplaza: hoy vence tu corte de 18090.00.','https://smarthouse-ve.com/Z4rwKp771903/?view=history&loanId=32&cutId=174','loan-due-today-cut-174-h01','2026-04-01 01:00:20','sent',1,1,1,0,'2026-04-01 01:01:01',NULL,'2026-04-01 05:00:01','2026-04-01 05:01:01'),
(92,17,24,93,'due_hourly','2026-04-01',2,'user:17:cut:93:due_hourly:2026-04-01:02','Corte con vencimiento hoy','Adrián Proautos: hoy vence tu corte de 500.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=24&cutId=93','loan-due-today-cut-93-h02','2026-04-01 02:00:00','sent',1,1,1,0,'2026-04-01 02:00:01',NULL,'2026-04-01 06:00:01','2026-04-01 06:00:01'),
(93,18,32,174,'due_hourly','2026-04-01',2,'user:18:cut:174:due_hourly:2026-04-01:02','Corte con vencimiento hoy','Deliplaza: hoy vence tu corte de 18090.00.','https://smarthouse-ve.com/Z4rwKp771903/?view=history&loanId=32&cutId=174','loan-due-today-cut-174-h02','2026-04-01 02:00:20','sent',1,1,1,0,'2026-04-01 02:01:02',NULL,'2026-04-01 06:00:01','2026-04-01 06:01:02'),
(94,17,24,93,'due_hourly','2026-04-01',3,'user:17:cut:93:due_hourly:2026-04-01:03','Corte con vencimiento hoy','Adrián Proautos: hoy vence tu corte de 500.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=24&cutId=93','loan-due-today-cut-93-h03','2026-04-01 03:00:00','sent',1,1,1,0,'2026-04-01 03:00:01',NULL,'2026-04-01 07:00:01','2026-04-01 07:00:01'),
(95,18,32,174,'due_hourly','2026-04-01',3,'user:18:cut:174:due_hourly:2026-04-01:03','Corte con vencimiento hoy','Deliplaza: hoy vence tu corte de 18090.00.','https://smarthouse-ve.com/Z4rwKp771903/?view=history&loanId=32&cutId=174','loan-due-today-cut-174-h03','2026-04-01 03:00:20','sent',1,1,1,0,'2026-04-01 03:01:02',NULL,'2026-04-01 07:00:01','2026-04-01 07:01:02'),
(96,17,24,93,'due_hourly','2026-04-01',4,'user:17:cut:93:due_hourly:2026-04-01:04','Corte con vencimiento hoy','Adrián Proautos: hoy vence tu corte de 500.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=24&cutId=93','loan-due-today-cut-93-h04','2026-04-01 04:00:00','sent',1,1,1,0,'2026-04-01 04:00:01',NULL,'2026-04-01 08:00:01','2026-04-01 08:00:01'),
(97,18,32,174,'due_hourly','2026-04-01',4,'user:18:cut:174:due_hourly:2026-04-01:04','Corte con vencimiento hoy','Deliplaza: hoy vence tu corte de 18090.00.','https://smarthouse-ve.com/Z4rwKp771903/?view=history&loanId=32&cutId=174','loan-due-today-cut-174-h04','2026-04-01 04:00:20','sent',1,1,1,0,'2026-04-01 04:01:02',NULL,'2026-04-01 08:00:01','2026-04-01 08:01:02'),
(98,17,24,93,'due_hourly','2026-04-01',5,'user:17:cut:93:due_hourly:2026-04-01:05','Corte con vencimiento hoy','Adrián Proautos: hoy vence tu corte de 500.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=24&cutId=93','loan-due-today-cut-93-h05','2026-04-01 05:00:00','sent',1,1,1,0,'2026-04-01 05:00:01',NULL,'2026-04-01 09:00:01','2026-04-01 09:00:01'),
(99,18,32,174,'due_hourly','2026-04-01',5,'user:18:cut:174:due_hourly:2026-04-01:05','Corte con vencimiento hoy','Deliplaza: hoy vence tu corte de 18090.00.','https://smarthouse-ve.com/Z4rwKp771903/?view=history&loanId=32&cutId=174','loan-due-today-cut-174-h05','2026-04-01 05:00:20','sent',1,1,1,0,'2026-04-01 05:01:02',NULL,'2026-04-01 09:00:01','2026-04-01 09:01:02'),
(100,17,24,93,'due_hourly','2026-04-01',6,'user:17:cut:93:due_hourly:2026-04-01:06','Corte con vencimiento hoy','Adrián Proautos: hoy vence tu corte de 500.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=24&cutId=93','loan-due-today-cut-93-h06','2026-04-01 06:00:00','sent',1,1,1,0,'2026-04-01 06:00:02',NULL,'2026-04-01 10:00:02','2026-04-01 10:00:02'),
(101,18,32,174,'due_hourly','2026-04-01',6,'user:18:cut:174:due_hourly:2026-04-01:06','Corte con vencimiento hoy','Deliplaza: hoy vence tu corte de 18090.00.','https://smarthouse-ve.com/Z4rwKp771903/?view=history&loanId=32&cutId=174','loan-due-today-cut-174-h06','2026-04-01 06:00:20','sent',1,1,1,0,'2026-04-01 06:01:01',NULL,'2026-04-01 10:00:02','2026-04-01 10:01:01'),
(102,17,24,93,'due_hourly','2026-04-01',7,'user:17:cut:93:due_hourly:2026-04-01:07','Corte con vencimiento hoy','Adrián Proautos: hoy vence tu corte de 500.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=24&cutId=93','loan-due-today-cut-93-h07','2026-04-01 07:00:00','sent',1,1,1,0,'2026-04-01 07:00:01',NULL,'2026-04-01 11:00:01','2026-04-01 11:00:01'),
(103,18,32,174,'due_hourly','2026-04-01',7,'user:18:cut:174:due_hourly:2026-04-01:07','Corte con vencimiento hoy','Deliplaza: hoy vence tu corte de 18090.00.','https://smarthouse-ve.com/Z4rwKp771903/?view=history&loanId=32&cutId=174','loan-due-today-cut-174-h07','2026-04-01 07:00:20','sent',1,1,1,0,'2026-04-01 07:01:02',NULL,'2026-04-01 11:00:01','2026-04-01 11:01:02'),
(104,17,24,93,'due_hourly','2026-04-01',8,'user:17:cut:93:due_hourly:2026-04-01:08','Corte con vencimiento hoy','Adrián Proautos: hoy vence tu corte de 500.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=24&cutId=93','loan-due-today-cut-93-h08','2026-04-01 08:00:00','sent',1,1,1,0,'2026-04-01 08:00:02',NULL,'2026-04-01 12:00:02','2026-04-01 12:00:02'),
(105,18,32,174,'due_hourly','2026-04-01',8,'user:18:cut:174:due_hourly:2026-04-01:08','Corte con vencimiento hoy','Deliplaza: hoy vence tu corte de 18090.00.','https://smarthouse-ve.com/Z4rwKp771903/?view=history&loanId=32&cutId=174','loan-due-today-cut-174-h08','2026-04-01 08:00:20','sent',1,1,1,0,'2026-04-01 08:01:01',NULL,'2026-04-01 12:00:02','2026-04-01 12:01:01'),
(106,17,24,93,'due_hourly','2026-04-01',9,'user:17:cut:93:due_hourly:2026-04-01:09','Corte con vencimiento hoy','Adrián Proautos: hoy vence tu corte de 500.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=24&cutId=93','loan-due-today-cut-93-h09','2026-04-01 09:00:00','sent',1,1,1,0,'2026-04-01 09:00:01',NULL,'2026-04-01 13:00:01','2026-04-01 13:00:01'),
(107,18,32,174,'due_hourly','2026-04-01',9,'user:18:cut:174:due_hourly:2026-04-01:09','Corte con vencimiento hoy','Deliplaza: hoy vence tu corte de 18090.00.','https://smarthouse-ve.com/Z4rwKp771903/?view=history&loanId=32&cutId=174','loan-due-today-cut-174-h09','2026-04-01 09:00:20','sent',1,1,1,0,'2026-04-01 09:01:02',NULL,'2026-04-01 13:00:01','2026-04-01 13:01:02'),
(108,17,24,93,'due_hourly','2026-04-01',10,'user:17:cut:93:due_hourly:2026-04-01:10','Corte con vencimiento hoy','Adrián Proautos: hoy vence tu corte de 500.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=24&cutId=93','loan-due-today-cut-93-h10','2026-04-01 10:00:00','sent',1,1,1,0,'2026-04-01 10:00:02',NULL,'2026-04-01 14:00:02','2026-04-01 14:00:02'),
(109,18,32,174,'due_hourly','2026-04-01',10,'user:18:cut:174:due_hourly:2026-04-01:10','Corte con vencimiento hoy','Deliplaza: hoy vence tu corte de 18090.00.','https://smarthouse-ve.com/Z4rwKp771903/?view=history&loanId=32&cutId=174','loan-due-today-cut-174-h10','2026-04-01 10:00:20','sent',1,1,1,0,'2026-04-01 10:01:01',NULL,'2026-04-01 14:00:02','2026-04-01 14:01:01'),
(110,17,24,93,'due_hourly','2026-04-01',11,'user:17:cut:93:due_hourly:2026-04-01:11','Corte con vencimiento hoy','Adrián Proautos: hoy vence tu corte de 500.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=24&cutId=93','loan-due-today-cut-93-h11','2026-04-01 11:00:00','sent',1,1,1,0,'2026-04-01 11:00:01',NULL,'2026-04-01 15:00:01','2026-04-01 15:00:01'),
(111,18,32,174,'due_hourly','2026-04-01',11,'user:18:cut:174:due_hourly:2026-04-01:11','Corte con vencimiento hoy','Deliplaza: hoy vence tu corte de 18090.00.','https://smarthouse-ve.com/Z4rwKp771903/?view=history&loanId=32&cutId=174','loan-due-today-cut-174-h11','2026-04-01 11:00:20','sent',1,1,1,0,'2026-04-01 11:01:01',NULL,'2026-04-01 15:00:01','2026-04-01 15:01:02'),
(112,17,24,93,'due_hourly','2026-04-01',12,'user:17:cut:93:due_hourly:2026-04-01:12','Corte con vencimiento hoy','Adrián Proautos: hoy vence tu corte de 500.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=24&cutId=93','loan-due-today-cut-93-h12','2026-04-01 12:00:00','sent',1,1,1,0,'2026-04-01 12:00:01',NULL,'2026-04-01 16:00:01','2026-04-01 16:00:01'),
(113,18,32,174,'due_hourly','2026-04-01',12,'user:18:cut:174:due_hourly:2026-04-01:12','Corte con vencimiento hoy','Deliplaza: hoy vence tu corte de 18090.00.','https://smarthouse-ve.com/Z4rwKp771903/?view=history&loanId=32&cutId=174','loan-due-today-cut-174-h12','2026-04-01 12:00:20','sent',1,1,1,0,'2026-04-01 12:01:01',NULL,'2026-04-01 16:00:01','2026-04-01 16:01:01'),
(114,17,24,93,'due_hourly','2026-04-01',13,'user:17:cut:93:due_hourly:2026-04-01:13','Corte con vencimiento hoy','Adrián Proautos: hoy vence tu corte de 500.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=24&cutId=93','loan-due-today-cut-93-h13','2026-04-01 13:00:00','sent',1,1,1,0,'2026-04-01 13:00:01',NULL,'2026-04-01 17:00:01','2026-04-01 17:00:01'),
(115,18,32,174,'due_hourly','2026-04-01',13,'user:18:cut:174:due_hourly:2026-04-01:13','Corte con vencimiento hoy','Deliplaza: hoy vence tu corte de 18090.00.','https://smarthouse-ve.com/Z4rwKp771903/?view=history&loanId=32&cutId=174','loan-due-today-cut-174-h13','2026-04-01 13:00:20','sent',1,1,1,0,'2026-04-01 13:01:02',NULL,'2026-04-01 17:00:01','2026-04-01 17:01:02'),
(116,17,24,93,'due_hourly','2026-04-01',14,'user:17:cut:93:due_hourly:2026-04-01:14','Corte con vencimiento hoy','Adrián Proautos: hoy vence tu corte de 500.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=24&cutId=93','loan-due-today-cut-93-h14','2026-04-01 14:00:00','sent',1,1,1,0,'2026-04-01 14:00:01',NULL,'2026-04-01 18:00:01','2026-04-01 18:00:02'),
(117,18,32,174,'due_hourly','2026-04-01',14,'user:18:cut:174:due_hourly:2026-04-01:14','Corte con vencimiento hoy','Deliplaza: hoy vence tu corte de 18090.00.','https://smarthouse-ve.com/Z4rwKp771903/?view=history&loanId=32&cutId=174','loan-due-today-cut-174-h14','2026-04-01 14:00:20','sent',1,1,1,0,'2026-04-01 14:01:01',NULL,'2026-04-01 18:00:01','2026-04-01 18:01:01'),
(118,17,24,93,'due_hourly','2026-04-01',15,'user:17:cut:93:due_hourly:2026-04-01:15','Corte con vencimiento hoy','Adrián Proautos: hoy vence tu corte de 500.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=24&cutId=93','loan-due-today-cut-93-h15','2026-04-01 15:00:00','sent',1,1,1,0,'2026-04-01 15:00:02',NULL,'2026-04-01 19:00:02','2026-04-01 19:00:02'),
(119,18,32,174,'due_hourly','2026-04-01',15,'user:18:cut:174:due_hourly:2026-04-01:15','Corte con vencimiento hoy','Deliplaza: hoy vence tu corte de 18090.00.','https://smarthouse-ve.com/Z4rwKp771903/?view=history&loanId=32&cutId=174','loan-due-today-cut-174-h15','2026-04-01 15:00:20','sent',1,1,1,0,'2026-04-01 15:01:01',NULL,'2026-04-01 19:00:02','2026-04-01 19:01:02'),
(120,17,24,93,'due_hourly','2026-04-01',16,'user:17:cut:93:due_hourly:2026-04-01:16','Corte con vencimiento hoy','Adrián Proautos: hoy vence tu corte de 500.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=24&cutId=93','loan-due-today-cut-93-h16','2026-04-01 16:00:00','sent',1,1,1,0,'2026-04-01 16:00:02',NULL,'2026-04-01 20:00:02','2026-04-01 20:00:02'),
(121,18,32,174,'due_hourly','2026-04-01',16,'user:18:cut:174:due_hourly:2026-04-01:16','Corte con vencimiento hoy','Deliplaza: hoy vence tu corte de 18090.00.','https://smarthouse-ve.com/Z4rwKp771903/?view=history&loanId=32&cutId=174','loan-due-today-cut-174-h16','2026-04-01 16:00:20','sent',1,1,1,0,'2026-04-01 16:01:01',NULL,'2026-04-01 20:00:02','2026-04-01 20:01:02'),
(122,17,24,93,'due_hourly','2026-04-01',17,'user:17:cut:93:due_hourly:2026-04-01:17','Corte con vencimiento hoy','Adrián Proautos: hoy vence tu corte de 500.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=24&cutId=93','loan-due-today-cut-93-h17','2026-04-01 17:00:00','sent',1,1,1,0,'2026-04-01 17:00:01',NULL,'2026-04-01 21:00:01','2026-04-01 21:00:01'),
(123,18,32,174,'due_hourly','2026-04-01',17,'user:18:cut:174:due_hourly:2026-04-01:17','Corte con vencimiento hoy','Deliplaza: hoy vence tu corte de 18090.00.','https://smarthouse-ve.com/Z4rwKp771903/?view=history&loanId=32&cutId=174','loan-due-today-cut-174-h17','2026-04-01 17:00:20','sent',1,1,1,0,'2026-04-01 17:01:01',NULL,'2026-04-01 21:00:01','2026-04-01 21:01:01'),
(124,17,24,93,'due_hourly','2026-04-01',18,'user:17:cut:93:due_hourly:2026-04-01:18','Corte con vencimiento hoy','Adrián Proautos: hoy vence tu corte de 500.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=24&cutId=93','loan-due-today-cut-93-h18','2026-04-01 18:00:00','sent',1,1,1,0,'2026-04-01 18:00:01',NULL,'2026-04-01 22:00:01','2026-04-01 22:00:02'),
(125,18,32,174,'due_hourly','2026-04-01',18,'user:18:cut:174:due_hourly:2026-04-01:18','Corte con vencimiento hoy','Deliplaza: hoy vence tu corte de 18090.00.','https://smarthouse-ve.com/Z4rwKp771903/?view=history&loanId=32&cutId=174','loan-due-today-cut-174-h18','2026-04-01 18:00:20','sent',1,1,1,0,'2026-04-01 18:01:01',NULL,'2026-04-01 22:00:01','2026-04-01 22:01:01'),
(126,17,24,93,'due_hourly','2026-04-01',19,'user:17:cut:93:due_hourly:2026-04-01:19','Corte con vencimiento hoy','Adrián Proautos: hoy vence tu corte de 500.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=24&cutId=93','loan-due-today-cut-93-h19','2026-04-01 19:00:00','sent',1,1,1,0,'2026-04-01 19:00:01',NULL,'2026-04-01 23:00:01','2026-04-01 23:00:01'),
(127,18,32,174,'due_hourly','2026-04-01',19,'user:18:cut:174:due_hourly:2026-04-01:19','Corte con vencimiento hoy','Deliplaza: hoy vence tu corte de 18090.00.','https://smarthouse-ve.com/Z4rwKp771903/?view=history&loanId=32&cutId=174','loan-due-today-cut-174-h19','2026-04-01 19:00:20','sent',1,1,1,0,'2026-04-01 19:01:02',NULL,'2026-04-01 23:00:01','2026-04-01 23:01:02'),
(128,17,24,93,'due_hourly','2026-04-01',20,'user:17:cut:93:due_hourly:2026-04-01:20','Corte con vencimiento hoy','Adrián Proautos: hoy vence tu corte de 500.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=24&cutId=93','loan-due-today-cut-93-h20','2026-04-01 20:00:00','sent',1,1,1,0,'2026-04-01 20:00:02',NULL,'2026-04-02 00:00:02','2026-04-02 00:00:02'),
(129,18,32,174,'due_hourly','2026-04-01',20,'user:18:cut:174:due_hourly:2026-04-01:20','Corte con vencimiento hoy','Deliplaza: hoy vence tu corte de 18090.00.','https://smarthouse-ve.com/Z4rwKp771903/?view=history&loanId=32&cutId=174','loan-due-today-cut-174-h20','2026-04-01 20:00:20','sent',1,1,1,0,'2026-04-01 20:01:01',NULL,'2026-04-02 00:00:02','2026-04-02 00:01:01'),
(130,17,24,93,'due_hourly','2026-04-01',21,'user:17:cut:93:due_hourly:2026-04-01:21','Corte con vencimiento hoy','Adrián Proautos: hoy vence tu corte de 500.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=24&cutId=93','loan-due-today-cut-93-h21','2026-04-01 21:00:00','sent',1,1,1,0,'2026-04-01 21:00:01',NULL,'2026-04-02 01:00:01','2026-04-02 01:00:02'),
(131,18,32,174,'due_hourly','2026-04-01',21,'user:18:cut:174:due_hourly:2026-04-01:21','Corte con vencimiento hoy','Deliplaza: hoy vence tu corte de 18090.00.','https://smarthouse-ve.com/Z4rwKp771903/?view=history&loanId=32&cutId=174','loan-due-today-cut-174-h21','2026-04-01 21:00:20','sent',1,1,1,0,'2026-04-01 21:01:01',NULL,'2026-04-02 01:00:01','2026-04-02 01:01:01'),
(132,17,24,93,'due_hourly','2026-04-01',22,'user:17:cut:93:due_hourly:2026-04-01:22','Corte con vencimiento hoy','Adrián Proautos: hoy vence tu corte de 500.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=24&cutId=93','loan-due-today-cut-93-h22','2026-04-01 22:00:00','sent',1,1,1,0,'2026-04-01 22:00:01',NULL,'2026-04-02 02:00:01','2026-04-02 02:00:01'),
(133,18,32,174,'due_hourly','2026-04-01',22,'user:18:cut:174:due_hourly:2026-04-01:22','Corte con vencimiento hoy','Deliplaza: hoy vence tu corte de 18090.00.','https://smarthouse-ve.com/Z4rwKp771903/?view=history&loanId=32&cutId=174','loan-due-today-cut-174-h22','2026-04-01 22:00:20','sent',1,1,1,0,'2026-04-01 22:01:02',NULL,'2026-04-02 02:00:01','2026-04-02 02:01:02'),
(134,17,24,93,'due_hourly','2026-04-01',23,'user:17:cut:93:due_hourly:2026-04-01:23','Corte con vencimiento hoy','Adrián Proautos: hoy vence tu corte de 500.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=24&cutId=93','loan-due-today-cut-93-h23','2026-04-01 23:00:00','sent',1,1,1,0,'2026-04-01 23:00:02',NULL,'2026-04-02 03:00:02','2026-04-02 03:00:02'),
(135,18,32,174,'due_hourly','2026-04-01',23,'user:18:cut:174:due_hourly:2026-04-01:23','Corte con vencimiento hoy','Deliplaza: hoy vence tu corte de 18090.00.','https://smarthouse-ve.com/Z4rwKp771903/?view=history&loanId=32&cutId=174','loan-due-today-cut-174-h23','2026-04-01 23:00:20','sent',1,1,1,0,'2026-04-01 23:01:01',NULL,'2026-04-02 03:00:02','2026-04-02 03:01:01'),
(136,17,23,89,'due_hourly','2026-04-03',0,'user:17:cut:89:due_hourly:2026-04-03:00','Corte con vencimiento hoy','Gaby Kalach: hoy vence tu corte de 1000.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=23&cutId=89','loan-due-today-cut-89-h00','2026-04-03 00:00:00','sent',1,1,1,0,'2026-04-03 00:00:02',NULL,'2026-04-03 04:00:02','2026-04-03 04:00:02'),
(137,17,23,89,'due_hourly','2026-04-03',1,'user:17:cut:89:due_hourly:2026-04-03:01','Corte con vencimiento hoy','Gaby Kalach: hoy vence tu corte de 1000.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=23&cutId=89','loan-due-today-cut-89-h01','2026-04-03 01:00:00','sent',1,1,1,0,'2026-04-03 01:00:02',NULL,'2026-04-03 05:00:02','2026-04-03 05:00:02'),
(138,17,23,89,'due_hourly','2026-04-03',2,'user:17:cut:89:due_hourly:2026-04-03:02','Corte con vencimiento hoy','Gaby Kalach: hoy vence tu corte de 1000.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=23&cutId=89','loan-due-today-cut-89-h02','2026-04-03 02:00:00','sent',1,1,1,0,'2026-04-03 02:00:01',NULL,'2026-04-03 06:00:01','2026-04-03 06:00:01'),
(139,17,23,89,'due_hourly','2026-04-03',3,'user:17:cut:89:due_hourly:2026-04-03:03','Corte con vencimiento hoy','Gaby Kalach: hoy vence tu corte de 1000.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=23&cutId=89','loan-due-today-cut-89-h03','2026-04-03 03:00:00','sent',1,1,1,0,'2026-04-03 03:00:01',NULL,'2026-04-03 07:00:01','2026-04-03 07:00:01'),
(140,17,23,89,'due_hourly','2026-04-03',4,'user:17:cut:89:due_hourly:2026-04-03:04','Corte con vencimiento hoy','Gaby Kalach: hoy vence tu corte de 1000.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=23&cutId=89','loan-due-today-cut-89-h04','2026-04-03 04:00:00','sent',1,1,1,0,'2026-04-03 04:00:01',NULL,'2026-04-03 08:00:01','2026-04-03 08:00:01'),
(141,17,23,89,'due_hourly','2026-04-03',5,'user:17:cut:89:due_hourly:2026-04-03:05','Corte con vencimiento hoy','Gaby Kalach: hoy vence tu corte de 1000.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=23&cutId=89','loan-due-today-cut-89-h05','2026-04-03 05:00:00','sent',1,1,1,0,'2026-04-03 05:00:02',NULL,'2026-04-03 09:00:02','2026-04-03 09:00:02'),
(142,17,23,89,'due_hourly','2026-04-03',6,'user:17:cut:89:due_hourly:2026-04-03:06','Corte con vencimiento hoy','Gaby Kalach: hoy vence tu corte de 1000.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=23&cutId=89','loan-due-today-cut-89-h06','2026-04-03 06:00:00','sent',1,1,1,0,'2026-04-03 06:00:01',NULL,'2026-04-03 10:00:01','2026-04-03 10:00:02'),
(143,17,23,89,'due_hourly','2026-04-03',7,'user:17:cut:89:due_hourly:2026-04-03:07','Corte con vencimiento hoy','Gaby Kalach: hoy vence tu corte de 1000.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=23&cutId=89','loan-due-today-cut-89-h07','2026-04-03 07:00:00','sent',1,1,1,0,'2026-04-03 07:00:02',NULL,'2026-04-03 11:00:02','2026-04-03 11:00:02'),
(144,17,23,89,'due_hourly','2026-04-03',8,'user:17:cut:89:due_hourly:2026-04-03:08','Corte con vencimiento hoy','Gaby Kalach: hoy vence tu corte de 1000.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=23&cutId=89','loan-due-today-cut-89-h08','2026-04-03 08:00:00','sent',1,1,1,0,'2026-04-03 08:00:02',NULL,'2026-04-03 12:00:02','2026-04-03 12:00:02'),
(145,17,23,89,'due_hourly','2026-04-03',9,'user:17:cut:89:due_hourly:2026-04-03:09','Corte con vencimiento hoy','Gaby Kalach: hoy vence tu corte de 1000.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=23&cutId=89','loan-due-today-cut-89-h09','2026-04-03 09:00:00','sent',1,1,1,0,'2026-04-03 09:00:02',NULL,'2026-04-03 13:00:02','2026-04-03 13:00:02'),
(146,17,23,89,'due_hourly','2026-04-03',10,'user:17:cut:89:due_hourly:2026-04-03:10','Corte con vencimiento hoy','Gaby Kalach: hoy vence tu corte de 1000.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=23&cutId=89','loan-due-today-cut-89-h10','2026-04-03 10:00:00','sent',1,1,1,0,'2026-04-03 10:00:02',NULL,'2026-04-03 14:00:02','2026-04-03 14:00:02'),
(147,17,23,89,'due_hourly','2026-04-03',11,'user:17:cut:89:due_hourly:2026-04-03:11','Corte con vencimiento hoy','Gaby Kalach: hoy vence tu corte de 1000.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=23&cutId=89','loan-due-today-cut-89-h11','2026-04-03 11:00:00','sent',1,1,1,0,'2026-04-03 11:00:01',NULL,'2026-04-03 15:00:01','2026-04-03 15:00:02'),
(148,17,23,89,'due_hourly','2026-04-03',12,'user:17:cut:89:due_hourly:2026-04-03:12','Corte con vencimiento hoy','Gaby Kalach: hoy vence tu corte de 1000.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=23&cutId=89','loan-due-today-cut-89-h12','2026-04-03 12:00:00','sent',1,1,1,0,'2026-04-03 12:00:02',NULL,'2026-04-03 16:00:02','2026-04-03 16:00:02'),
(149,17,23,89,'due_hourly','2026-04-03',13,'user:17:cut:89:due_hourly:2026-04-03:13','Corte con vencimiento hoy','Gaby Kalach: hoy vence tu corte de 1000.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=23&cutId=89','loan-due-today-cut-89-h13','2026-04-03 13:00:00','sent',1,1,1,0,'2026-04-03 13:00:02',NULL,'2026-04-03 17:00:02','2026-04-03 17:00:02'),
(150,17,23,89,'due_hourly','2026-04-03',14,'user:17:cut:89:due_hourly:2026-04-03:14','Corte con vencimiento hoy','Gaby Kalach: hoy vence tu corte de 1000.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=23&cutId=89','loan-due-today-cut-89-h14','2026-04-03 14:00:00','sent',1,1,1,0,'2026-04-03 14:00:01',NULL,'2026-04-03 18:00:01','2026-04-03 18:00:01'),
(151,17,23,89,'due_hourly','2026-04-03',15,'user:17:cut:89:due_hourly:2026-04-03:15','Corte con vencimiento hoy','Gaby Kalach: hoy vence tu corte de 1000.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=23&cutId=89','loan-due-today-cut-89-h15','2026-04-03 15:00:00','sent',1,1,1,0,'2026-04-03 15:00:02',NULL,'2026-04-03 19:00:02','2026-04-03 19:00:02'),
(152,17,23,89,'due_hourly','2026-04-03',16,'user:17:cut:89:due_hourly:2026-04-03:16','Corte con vencimiento hoy','Gaby Kalach: hoy vence tu corte de 1000.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=23&cutId=89','loan-due-today-cut-89-h16','2026-04-03 16:00:00','sent',1,1,1,0,'2026-04-03 16:00:02',NULL,'2026-04-03 20:00:02','2026-04-03 20:00:02'),
(153,17,23,89,'due_hourly','2026-04-03',17,'user:17:cut:89:due_hourly:2026-04-03:17','Corte con vencimiento hoy','Gaby Kalach: hoy vence tu corte de 1000.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=23&cutId=89','loan-due-today-cut-89-h17','2026-04-03 17:00:00','sent',1,1,1,0,'2026-04-03 17:00:01',NULL,'2026-04-03 21:00:01','2026-04-03 21:00:02'),
(154,17,23,89,'due_hourly','2026-04-03',18,'user:17:cut:89:due_hourly:2026-04-03:18','Corte con vencimiento hoy','Gaby Kalach: hoy vence tu corte de 1000.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=23&cutId=89','loan-due-today-cut-89-h18','2026-04-03 18:00:00','sent',1,1,1,0,'2026-04-03 18:00:01',NULL,'2026-04-03 22:00:01','2026-04-03 22:00:01');
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
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `device_id` varchar(120) NOT NULL,
  `endpoint` varchar(700) NOT NULL,
  `p256dh` text NOT NULL,
  `auth` text NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_push_endpoint` (`endpoint`),
  KEY `idx_push_device_id` (`device_id`),
  KEY `idx_push_user_id` (`user_id`),
  CONSTRAINT `fk_push_subscriptions_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `push_subscriptions`
--

LOCK TABLES `push_subscriptions` WRITE;
/*!40000 ALTER TABLE `push_subscriptions` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `push_subscriptions` VALUES
(19,20,'d14f4631-d972-49f1-970a-53df763b3df8','https://fcm.googleapis.com/fcm/send/dtx5fNkedCw:APA91bH01NtZWdit-R5F22yXumuAnnBKe0qh7DOSdGfSNLZLq_M2FhgZ44d06613KtwZbZhft_Icko8jSImWmWeYv9XPwgL-06EzVESPMcb4W9P2btT_J6gn2lbRQRmf3IDlEzHm__st','BOozOjdG40k_UlN9DLqODrgNCdsYZ3FWElh1Ue_9HzrE4TbgiU9SbRj17gf-uTA0zudT_KGB5VDgb2aab1kkKFE','wy6-9jvOXelAM2P0ft9f4Q','2026-03-25 23:08:35','2026-03-25 23:08:35'),
(20,20,'588a28a4-8541-4fb9-960c-a4aab48372fb','https://web.push.apple.com/QDg6wgX9GtiaBOStW_LSA6Ln9Vaztuxvr-MWpvFYdVHf9kj5nmLcnPjFtSoGjwKjSvxPHB_QG-6THDOtqc5ZBu_p2gzKJcCxYy8JnmhqcRCYn25Pq0mf0g2Jt2neK2I0ITGlqWc6ZaMXGwdBOsMZ1xsxQk1KNRGWJig_bpd4sUI','BO9FHzl1o35rXJJhrDsbuRZNbYsSE63lYrXUy6Xl0GtV40WVZZ-MiFmwTCmWv-h3Rf4vGBEQ4iqEeMOu_x37Chc','Qks11iQZw5-dtvTeTkOySA','2026-03-25 23:08:42','2026-03-25 23:08:42'),
(21,17,'d62144f0-9f54-470d-b928-566cd5cfe0e5','https://web.push.apple.com/QA-OuxEpKDCn_OmyTgXcO407468qcZNAqrWE9EmH0oBh5NLkw8yK5IhGRPfQ-KsTZZNyPeWa9O6JBcBd0olnE9oHb11n95koxpwHnwGaI4DWET2pJOs3qgJxyDAHlZvt7Nt8RmeSyY2EuhWwG8K0blivn3qZrw_4PzveI1HOtVY','BPiNSDp9VtKpRbkN8H7zMilUcrpYjLjm5Hi0mBzjKDuZ5JTCsr6n6MAYKtL2zFm2_b2aVK10ReowtxfkJDErxHQ','ltbhwsaGljzdgWc4ao-oTw','2026-03-25 23:13:46','2026-03-25 23:13:46'),
(22,18,'147fb720-82c7-4a69-b445-d3c74124a2b3','https://web.push.apple.com/QFqE7yEoEyqqdT-w0uYGngZbOMXbjjgcCbOd7rPeIFUwvND155DQlD_uIE8KCiRdi3JVEO-YwGhoGB2aoE3Yk01HCaRb1COCalu5zn0CcJbEX2M8eAcrOdqwu4mlwMRWOxvjmBdtsqxK98EBEnYybupS3JXbYFBXqloloxr4oj0','BBMpcXBiIdRfO8UVLeTcRsjYO19TqbvwnfOpJgqgTi8UIXnmpHWXjacb6KeSFlEbmXJ9RaHP25KjRpFMcNPt8_I','5m9HfIdGyXIqhfVilL58Gw','2026-03-30 18:52:37','2026-03-30 18:52:37');
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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
(6,'prueba reunion','2026-03-25','09:00:00','Maracay',4,'todo bien',6,1,'completada'),
(7,'Jola','2026-03-26','09:00:00','oficina',NULL,'Hola',19,0,NULL),
(8,'preu','2026-03-26','09:00:00','oficina',NULL,'Reunion',6,0,NULL),
(9,'todos','2026-03-30','09:00:00','oficina',NULL,'todos\nReprogramada: debemos reprogramar',6,0,'reprogramada'),
(10,'todos','2026-03-27','09:00:00','oficina',NULL,'todos',156,0,NULL),
(11,'todos','2026-03-27','09:00:00','oficina',NULL,'todos',5,0,NULL),
(12,'todos','2026-03-27','09:00:00','oficina',NULL,'todos',7,0,NULL),
(13,'todos','2026-03-30','09:00:00','oficina',NULL,'todos\nReprogramada: Necesario',19,0,'reprogramada'),
(14,'todos','2026-03-27','09:00:00','oficina',NULL,'todos',9,0,NULL),
(15,'reunion importante','2026-03-27','09:00:00','oficina',4,'reunión',23,0,NULL),
(16,'Rosa2','2026-04-01','09:00:00','Casa de rosa',NULL,'Reprogramada: Dorito',19,1,'reprogramada');
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rutas`
--

LOCK TABLES `rutas` WRITE;
/*!40000 ALTER TABLE `rutas` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `rutas` VALUES
(1,4,'Test','08:30:00','12:30:00','[\"la arboleda\",\"el valle\",\"cualquier cosa\"]','{\"lat\":10.187529,\"lng\":-64.634298}','[\"volantes entregados\",\"Visitas\",\"Muestras\"]',NULL,'[{\"id_agente\":6,\"requisito\":\"volantes entregados\",\"resultado\":\"29\"},{\"id_agente\":6,\"requisito\":\"Visitas\",\"resultado\":\"13\"},{\"id_agente\":6,\"requisito\":\"Muestras\",\"resultado\":\"5\"},{\"id_agente\":19,\"requisito\":\"volantes entregados\",\"resultado\":\"10\"},{\"id_agente\":19,\"requisito\":\"Visitas\",\"resultado\":\"10\"},{\"id_agente\":19,\"requisito\":\"Muestras\",\"resultado\":\"5\"}]','buena vista'),
(2,4,'Maracay','08:30:00','12:30:00','[\"Maracay\",\"Urbanizaci\\u00f3n el centro\"]','{\"lat\":10.236058,\"lng\":-67.59797}','[\"Casas\",\"apartamentos\"]',NULL,NULL,NULL),
(3,4,'centro','08:30:00','12:30:00','[\"corinsa\"]','{\"lat\":10.169819,\"lng\":-67.462114}','[\"Contactos\",\"Personas\",\"Volantes entregados\"]',NULL,NULL,NULL),
(4,4,'corinsa','08:30:00','12:30:00','[\"Avenida Turmero\"]','{\"lat\":10.170372,\"lng\":-67.460949}','[\"vistas\"]',NULL,NULL,NULL);
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
('0cdGJAKXAICkp078ndknznFXIQBVy4dqKkDYA21S',NULL,'172.71.159.166','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1','YTozOntzOjY6Il90b2tlbiI7czo0MDoiV0tmdmY2NWduNVdHNHJIOWlVWWp2alozYm9BbE5sSGl4MkJKcVIybiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775220913),
('2ooKA8sTuoCTjudVf3s8GeBh3dnWxSxPNI0BAFop',NULL,'172.71.159.165','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1','YTozOntzOjY6Il90b2tlbiI7czo0MDoiQndDOTI2bXpOQWxLZjZmUmxxTTdpWDdUQUp2N2JnS0tReG9TVUxtWCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775173132),
('3JplRwWWcZQsbCpIPucYIJWwp1PjtqX7ONSZeWyV',NULL,'162.158.111.140','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1','YTozOntzOjY6Il90b2tlbiI7czo0MDoiNFJKVWZBdk85UmpJcW0xcENaZnNlMk1rN240MlF5T1Iwc1BrT3dpVyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775007966),
('5GLSmeg1CAkvl7XZNDiKZC85VRJE4RzKqr0MnnDj',NULL,'172.69.23.83','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1','YTozOntzOjY6Il90b2tlbiI7czo0MDoiUzRoT0dST2N4dzZ6U004S1BTcDdSbzlLS3lkaXVFWndYTHR2TW9SZCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775092237),
('82oJQrCpCFdtWCYXeudrzcYlkswtlMsJL0B1foip',NULL,'104.23.221.109','Mozilla/5.0 (Android 14; Mobile; rv:123.0) Gecko/123.0 Firefox/123','YTozOntzOjY6Il90b2tlbiI7czo0MDoiZ1Y0SHJ3RjFZM2F0SVVXelV4dmllb3l5T1ZPcDdvTEE1RU9Bc2R6eCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775076438),
('8ojR20eelNQ2yrWdvCro0itswCq0P4OVkhhlPZYB',NULL,'104.22.23.16','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiaEpyZ1o5TjhOZGtFOUhSRllad1Z1cVVKYnlKZ3lVWXRnaHFSQ0hjbSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775150099),
('Ancd9Cjtk5zMMcRKZtzL0DM1hLfCtDUpujvTs88K',NULL,'108.162.216.212','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoieWEzQ2RLb1VKaDlMNk1uUWlDSjJKNXFJeHA1V0FrdGtNRU8zTzVOTiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775075679),
('aOfE6NLzwswOlw9T3lzHlfgI3faOzdVHRasc20Xm',NULL,'104.22.23.17','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiTnNZeFppMHdxdVMzV1FqQkVDb0dzb3MxS044bVBsdTBXUTJzbWdLWiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775051040),
('C5ir7Tgvjiq4trLlHNmi8mvLM7GwsdA7WiliDMaX',NULL,'162.158.217.144','Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Mobile Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiYzZPN3NIbGhnMlRlaUFUY2d0UUxoaENpakE4dlZKNzFRcFp3QnB1NyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775108317),
('cFQ1n8XxtUKnKSI0clH2OasrHJig6O5SjyhFTdE5',NULL,'172.70.127.137','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiV3B0bGM1MExjOUVWTlNrbDVvZ0dFTUdLR1RPVlFzN2hneE9ZS29BdCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1774985565),
('CUhTo5ejKs8K3tc8jAvwGQZUTgCHoSWSET78GIxJ',NULL,'172.69.6.104','Mozilla/5.0 (iPhone; CPU iPhone OS 26_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/144.0.7559.95 Mobile/15E148 Safari/604.1','YTozOntzOjY6Il90b2tlbiI7czo0MDoiVkFzbThCZ3dGYkRHZUJURWhoM0ZYbXIxdGxhMlNqWlBoazFzOWlvbCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775070656),
('DnUj7CyqVCjexsswwG7a8k5tb4dmIxTLqnRGjxIP',NULL,'172.71.82.61','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1','YTozOntzOjY6Il90b2tlbiI7czo0MDoiaE5VemtUYUtxbUNJdUY1M0dKa3Z2VHVBRE5lYUFkRzdyU25UOGRDWiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775005833),
('ehbnTdC3VCR9WAHJPQXIlxEpiCdgdtMFBJWqUL45',NULL,'104.23.253.25','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0','YTozOntzOjY6Il90b2tlbiI7czo0MDoiTnhZM1hseGdiUTRpMGR2aDZCWVlpOTRHVzJuVjQ1cGxiMVB2Q29DTyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775125742),
('eZSvCUrRhUkeEh2WoWz80MMCKalTlXqYrZFvfWF1',NULL,'172.69.234.167','Mozilla/5.0 (Macintosh; Intel Mac OS X 15_7_3) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.0 Safari/605.1.15','YTozOntzOjY6Il90b2tlbiI7czo0MDoiY1Y1bmZNTnpLdnNzQzJsR21uZlpzNnZ5ZTFtNHRtNEJHR09jN2lwRyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775173475),
('fpMLWrU4CH74RId9pXSxeT0CDMJxzIM0a02BaqiY',NULL,'162.158.159.158','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiTUNhUnNWZU9MT24yd0J6ZXZGTzIzNUhJUEI5MUNBUFJaZUltMWF3cCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775058225),
('FrG7YO5LkaIT2oCLW8ducOrlk7UzNkpN6uNxPjt2',NULL,'104.23.168.39','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1','YTozOntzOjY6Il90b2tlbiI7czo0MDoiQnp3NVdqUm41Y2FFQmF6bEhtNzA0TEVLSXdScU5ydVpFY0JxOXNWUSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775015812),
('FyAljUAXELKjQEsYbrjDCWB1NAc3yTDnyN42D5fp',NULL,'172.70.38.87','Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101 Firefox/102.0','YTozOntzOjY6Il90b2tlbiI7czo0MDoiam5rdEZWZmg5UWFFSFJmY0lGRkVFOHhmemxOMFdMSDhqVnJaMERJSCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775096407),
('gdCXwzs7MIqf7bT0wcNT0nRFxkRkru3mNX6CPzef',NULL,'172.69.222.97','Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)','YTozOntzOjY6Il90b2tlbiI7czo0MDoiOE9GQlpBbXZKMEJtYmk5OWZxd05wY2xaSzJ1cjFHSlQyZGRhNHlMSiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775123225),
('h6GfMD8BF7IvrpB75xh4kw1NdBMyo2NVgusLrZHD',NULL,'162.158.216.112','Mozilla/5.0 (X11; Fedora; Linux x86_64; rv:114.0) Gecko/20100101 Firefox/114.0','YTozOntzOjY6Il90b2tlbiI7czo0MDoidGtUcHk1U3pTbmpTWDgwbTBsOHlENzZRaEdzSDI2ZDB5RmloT1haVSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775000063),
('HSIwIbui3u9j9umNHOl0jrzBqmZOQKGT7nYpKHk6',NULL,'141.101.76.74','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1','YTozOntzOjY6Il90b2tlbiI7czo0MDoiWXBzVmhCandsY3JDWmhva0RLRmVYeURzaFVHRTF1M3NMZ2FHZVY4OSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775110376),
('HZid3ADCoen3DZ68Wbf4XQt0VPd9T6I4NVFJipbN',NULL,'104.22.17.195','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:104.0) Gecko/20100101 Firefox/104.0','YTozOntzOjY6Il90b2tlbiI7czo0MDoiREhocURsSU92dGphNUdlTXRGVXYxbUQ0ZWVRNTgxNVpPT3Z6UE44WSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775210031),
('IIHkH3T6K5sp6lvkteU53V8ChcWHhycz4d2CT8JE',NULL,'162.159.106.82','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.5938.132 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoid0JDV25hU2lGVHloS1c3b1g0eWNwdnRKQlgyMUJKeGk3NDdjS3JvViI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775076322),
('IyPT00cV2v2cioIhW2dHCI55h0poXO1iBBxYm771',NULL,'172.71.159.166','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1','YTozOntzOjY6Il90b2tlbiI7czo0MDoiOG5MQklHY2R5V0FQTFQ5M3AwZmxkR2RqdnJDZkM1OXdWaVAwa0pZUSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775077892),
('JNH0POA5aJbdkudFOI18iT9QkNrXCebgdXxrxthl',NULL,'172.69.176.122','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1','YTozOntzOjY6Il90b2tlbiI7czo0MDoiMnpkM1BXN21rRkEzeTY0c2Y3dlgwUmdhUDRMVkc0eWRoN1dHR2JNRCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775101920),
('jOLQewKakQObZw00BInzVK5wf3vQ9qGnms9UlRiT',NULL,'104.23.170.81','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1','YTozOntzOjY6Il90b2tlbiI7czo0MDoiOXBSdkYxV3JTZWNEcEFrQ09CNTkyQUJsbTJ0RVJ5dXZXSlR3Zm1UTyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775063117),
('k1Obw7xyWfNhmgo5T2NIP1RN0zWVk2JAD7y2Ugp9',NULL,'172.69.214.40','Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)','YTozOntzOjY6Il90b2tlbiI7czo0MDoiQlZWeVVhQzE4czNXNEhVOVgxMUxOZWxHM1R0NTYxRGJhUlhwNXg2UiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775011632),
('kISh9xtnVR5iYPTm8JmY1FWEzEShoU9f5wOBc7NM',NULL,'172.71.95.89','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1','YTozOntzOjY6Il90b2tlbiI7czo0MDoicWJUaVNkU2pkZDhTcng5NWk3NTNtS29QNVRrQ2t0cWx6SE1xN1UwaSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775158178),
('LAqiErrknWlkI7qnQFCEU7WKBzqVFIieXLuAqtrg',NULL,'172.68.243.206','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiTWlnSlpUU3FQREhubzBMbFo1bkZlV0hUd1hLc0tjNXM4NkU4SnUxciI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775068079),
('mfK8urXw1rCX2HwSVARn7YBUWVVDsetUOvIp5orw',NULL,'172.71.155.9','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1','YTozOntzOjY6Il90b2tlbiI7czo0MDoiTDdsb1VwMXFTdWhGTkRzbXg2Zk5KQm01THowdHJ5VzVST1d4WFJIaCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1774983600),
('mIdyQ2XQqFac29xP2QiDsulTZSIN4YtyQXDtKCFn',NULL,'172.69.17.7','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiVnFRbmx3YnBaODZIS3NFRVVIZDVweFcxN3V2WWRNeW9rc3hraGtCeiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775075607),
('mTJfGQXuwltbdw3O8Hk7lJH4IHeW3OgnykVYiTvJ',NULL,'172.71.255.44','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoibFBZTmlHbE10NjVpenFmNXp5QU4xZ0lCOTdITHd3RHZSUHJCY1BIQSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775107993),
('MVtaC38RtqtHvCj1qhUO8Kfw1GetDf38nG3zremy',NULL,'172.71.238.156','Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity','YTozOntzOjY6Il90b2tlbiI7czo0MDoiWlpwOE5lZnhkYXlHSk9jZExTQzFldVNEbEkySHgwc2ZDSmpmZmdNVyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775021394),
('mZDHLUOMKKBS3jazjnmwYsTQqC0UaurHeL0k6x8P',NULL,'172.71.255.44','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoieEJjRFRDdzZodU1mZkV4d2JrOG1QVmkxcU5SdnJkZjQ0Ujk2OXhycCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1774985377),
('NJuRUcy7Nq3MoEgyTsZxwZhaI4uPnG0LtIYfdcZn',NULL,'104.23.223.2','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.3','YTozOntzOjY6Il90b2tlbiI7czo0MDoiN1FIWTh1TzJiVmhrRzVuaGo2OEVCV3Q5OEVDYUVMM2ZrRkJPYU1pSiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775190168),
('NKLyJQ5pXxMWZk4wQmO0AtNy2laTQJzCI6iMDMhU',NULL,'172.71.182.47','Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)','YTozOntzOjY6Il90b2tlbiI7czo0MDoiWnZrNFRvb1VHdkczaURvUVBDYlNyUEV4WW02TjNsU3A5c1dneGtWNCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775233561),
('NOeRYQBhq6IRzmyQkmktBMLgU1At1iElOT2uAC8o',NULL,'104.22.20.158','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1','YTozOntzOjY6Il90b2tlbiI7czo0MDoiTUFVYlNLcWVMZFFwNHdVM0NDQUhhN2g0ZWY4Z2V3RHZkcldzUVdVRCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775178812),
('NOWhINKMWfqbVB2NKMqRvH6zfBPkluWXVkoCOinI',NULL,'172.71.159.166','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiRE5wSmFTaTFKdUxSd2JuYnBTWnhFckVIVUY3UmF4MTBOckhSWXNJSiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775126312),
('nZg79WTmYa4Z8qN2qwIRA1bI69PE3QbGG4t1pxXW',NULL,'104.22.20.158','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiVEx6SGpyUnFBOWM1RHk3WEgxemFyUGlsWDZzNzluOUNOcUlGaG43ZyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775138807),
('odQNYLdnxqWGQfVxuTLoImvSIDRYKesC9Xiwh2Fb',NULL,'172.68.234.33','Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1','YTozOntzOjY6Il90b2tlbiI7czo0MDoiNXFBQnpScW5nZDJXZFUzUTNYb0hLU3pDcUN5ZVNJUUdYSFM5UllaNyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775032806),
('P075eeSU2BJgZU3Zg14218gZioQ45xPo2IqDbYmJ',NULL,'104.22.62.115','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoickh3ZE1mY1o1VjVFbDNMYXhOamlVcVI1YzJjbTlzdW1iYWc1YWhiRCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1774985563),
('qoBZeNWjmxyYzsO2jkYAGT3bBltLzNdsFNWX8T4E',NULL,'172.64.223.166','Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:72.0) Gecko/20100101 Firefox/72.0','YTozOntzOjY6Il90b2tlbiI7czo0MDoiVUFvTGs1YkdmN1h6b1JWdVYzYXRhSWVvTFBqdGJlRU56aVk1Y1o4WCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775068898),
('qsO2ECrQzguvM0hUZLFsc0fWEQVPDC86taHG3Oo6',NULL,'172.71.127.140','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4240.193 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiVUl6TXFXOGhNT1RDRjFwMmFtSzFQN1k1U3RGVWM5RlVrVFFXc1NLTyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775185009),
('R545Ia5rCdvpiCzbqaLyCsyFkruMq8fUCYNfqhNQ',NULL,'172.70.111.163','Mozilla/5.0 (X11; Linux x86_64; rv:142.0) Gecko/20100101 Firefox/142.0','YTozOntzOjY6Il90b2tlbiI7czo0MDoiWFhiZ0JMY1Bya2dVYm9hRDZKMlpFa0dFRmtIbU9VdW9WM2tWU1JpRSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775136445),
('RgAevW4U6gomCwfMrlUAJXyrrWRHYu6qgpS3SLh9',NULL,'104.22.20.159','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1','YTozOntzOjY6Il90b2tlbiI7czo0MDoiT2pvRmlNaHN4YjZwNnJOSmZvdkJKV3JwUnlJN01OdDRwYU5jOWx1NCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775198164),
('roVFzAbWMjHEmuVSgd9ZWsUTL8xowijy9dEMc6tr',NULL,'172.71.135.15','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiSFdOcGRhMmlaM2ZqanN2M2FEMTF2Q2xtRU5za2tPVXhibGY3ejgwNSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MTE0OiJodHRwczovL2s3cHIyd245eG00dGI2dmwxenE4LmluZm8vaW5kZXgucGhwP29yZGVyPWFzYyZvcmRlcmJ5PWlkJnBhZ2U9MSZwZXJfcGFnZT0xMDAmcmVzdF9yb3V0ZT0lMkZ3cCUyRnYyJTJGdXNlcnMiO3M6NToicm91dGUiO3M6Mjc6ImdlbmVyYXRlZDo6SDB6Nk9zN3F1NGpVRWdYbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=',1775100073),
('SSaCB9imSDQ9MEv73LoeQSH4EPNhGAmn6gsuO7Ma',NULL,'104.22.20.159','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1','YTozOntzOjY6Il90b2tlbiI7czo0MDoiVTBzWnhpT2cweEF1WHpWTnRaRnJlQm03b1hjSGw1THBWMHJnOEtXVSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775031198),
('taLY9jg7lUI3PFuaX8AbxEMRKCdLBWRkRtkkkD7E',NULL,'172.70.47.17','Mozilla/5.0 (Linux; Android 10; Nokia 3.2 Build/QKQ1.191008.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/80.0.3987.162 YaBrowser/19.6.0.158 (lite) Mobile Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiOFY3WGtlYVV5SzRmcUxLa3ZVZk1IdXM5bVpadHNBRXRncnRubk1rVyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775189568),
('Tawi0A3QUhK9zFFm3DDG2lWmL4jZ40Ab3xeAnEP9',NULL,'108.162.249.74','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiaUhOdmJpMXduSXh5c1VCN1l3UWJPWW92bzJiVkVVT3pqYmlkNlpRSiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775061954),
('UcVe8mVINU9ONeGwcp9Pv6zg8i159bhXyl7x6RH6',NULL,'172.71.223.27','Mozilla/5.0 (iPhone; CPU iPhone OS 26_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/144.0.7559.95 Mobile/15E148 Safari/604.1','YTozOntzOjY6Il90b2tlbiI7czo0MDoielQyeUNFeE1CeFRmRmlTRzBWNEVTc01MNzhnZlQxZFAxbVc5RDBTaCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775070635),
('vVLx4AID3YdwLUACFnlE0SCThy86DHDas4p8GpsI',NULL,'104.22.17.195','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:65.0) Gecko/20100101 Firefox/65.0','YTozOntzOjY6Il90b2tlbiI7czo0MDoicjhwS3dxNUFuNmZrdlNsQVJCTjVueU02R29Jd3V6VWFLaVc5VDFrNyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775167881),
('Vzk6h3iLvrclti2dRAyV8sScDfdHTsHFFS1Qs3WG',NULL,'104.22.20.158','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiakhZRTZRNk4xZmNCTDI0Y3BhOTJuQldySmRXM2NBMElOa0kxRkZMMiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775157918),
('wGHQ4G3qfuVU5GUyOG7LYbPQ6tuAJRwJRcwQx6lE',NULL,'162.158.217.145','Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Mobile Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiYVJBYjREY2FjRTNlU2pYT2FxT0lldVJaZ0FhMVlaSFJTSzRVSDhyTyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775111728),
('wTKa9Yf4GMzVWtEPYJRQcFGVMt5PhlLBWqVDVdSs',NULL,'104.23.160.96','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoic3hQOFpIbWlJZktvUlBhbkJJSFFhcHo2Yk9NTDBnaGhLd0xwd2o3ZCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775119629),
('WVieq2pJNvqSxxNP5BZYzzkmarJuQpLN8tft2qyg',NULL,'172.71.155.9','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1','YTozOntzOjY6Il90b2tlbiI7czo0MDoiVnA5bHk1TW5uUEVnaFZGNXJBS0s4QWJQajQyZk5HaTNJZlEzVVBRcCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775052887),
('X8Y4ZRr9zroL4mIOza2bE6TUJwYEH4z8vTUqwChg',NULL,'172.69.114.54','Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity','YTozOntzOjY6Il90b2tlbiI7czo0MDoiTWMybkVLc2dZSjNyd0ZGZDZGcXA0ME5BRXVKTVl2UjRmTEpKREdWVSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775057730),
('xaJ0ZiRfSCeIfWQPndEH5cYaXTqz93y1sYFBMymg',NULL,'104.22.62.114','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoibExOTzlyMWd6ZG5QRGpGb0VETmoxbzZ3elVENUNUZUhzQlBBbGlwciI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775165445),
('XEmwgxQfy1uWUBIjT1Y6AWDUS4jGZPhpCAAxMpyO',NULL,'172.69.58.246','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiUm42ZEtqbm1zWG9aRE5xMTR2eWFkbVE5V1htSkFNak9yTXRUU2N1NiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775165444),
('xsOxVvRTxuO8j6fKWzSpnxxSMcbgvMQka2mnHTG5',NULL,'172.69.17.6','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiUmNzS2x1Nk9ld3ZFVE9QaVlDTVY3R3ZkbEJLY25iTldZdWI0SnlGZSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775075677),
('xZcgX9K9OBSpJxHLztshk7Fkkpw0HxsCkl9ozVuj',NULL,'172.70.174.139','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1','YTozOntzOjY6Il90b2tlbiI7czo0MDoiYnFNSWVqU0FkYW1OUWJ6SVEwdnh6SEZzV0M2OEJxSGxudEFzN2hvQSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775124564),
('Z3HULVJ0WUa7ewUJP7zMxNlLEVU8Na308ZigyJSV',NULL,'172.71.124.208','Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)','YTozOntzOjY6Il90b2tlbiI7czo0MDoiZER0OExpajdpY0dmNUF4SUJCeVh5b1dGeTNFbEh6cE9jRml4UFE2SSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775198983),
('zgoGKbfQyKjSIUxOPHJSmBrE5uBptHZ9pes4zLbX',NULL,'172.70.127.138','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiZkQ0YUR2V3FrTDlKcXY2c1RiRWl0Tm92R282U3I3ZU5ITFdRWUFhTiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775165578),
('zQ1EHSvNkUTnFa21cVZexaAyNbRamH7QhG0h7Spd',NULL,'172.69.23.83','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1','YTozOntzOjY6Il90b2tlbiI7czo0MDoiVnJQSDloVEEwcnNUdkViWlNuQW1MZHBsVXFaRDhGTWRrZ3IwcW9OViI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjpIMHo2T3M3cXU0alVFZ1huIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1775146704);
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
  `ref` int(11) DEFAULT NULL,
  `estado` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_solicitar_ciudad_zona` (`ciudad`,`zona`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `solicitar_ins`
--

LOCK TABLES `solicitar_ins` WRITE;
/*!40000 ALTER TABLE `solicitar_ins` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `solicitar_ins` VALUES
(1,'Yonnel','04129168395','Caracas','Cara','Casa',20000000.00,'Casa','[]',12,NULL),
(2,'sadas','041254512048','Caracas','asd','casa',2000.00,'sdas','{\"numero_dormitorios\":3,\"cantidad_banos\":3,\"area_minima_m2\":200,\"estacionamientos_minimos\":200,\"con_piscina\":true,\"pet_friendly\":false}',5,NULL),
(3,'Casaaa','0412456124156','Cagua','Corinsa','Casota',120000.00,'Una casa habitable','[]',23,NULL),
(4,'sdds','0145241564565','Maracay','Altamira','Casa',200000.00,'casa','[]',25,NULL);
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
  `url` varchar(254) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `users` VALUES
(2,'Mis huevos Redondos','agente_test_01@smarthouse.local',NULL,3,'$2y$12$.Xq5bJ7Flzd6fcmESFW69.2kJ.m2Y5VN5Kw48UuDPrqUhDzgrLeyK',NULL,'2026-03-17 23:26:18','2026-03-17 23:26:18',NULL),
(4,'Laura Mendoza','admin@a.a',NULL,2,'$2y$12$jd8CdHgY33NvHxkTl6VE6.dzQ235P2HQeK34IyH3uog0OVZIsB1km',NULL,'2026-03-17 23:43:14','2026-03-17 23:43:14',NULL),
(5,'Luis Mora','mora@fm.com',NULL,3,'$2y$12$Ii9N6HD3LtYVp/EtFpM4oO2hOLAr/FzDyDlaQ9rlcdHlojG24KoDS',NULL,'2026-03-17 23:54:13','2026-03-17 23:54:13',NULL),
(6,'Raul de Cervantes','raul@sm.com',NULL,3,'$2y$12$SiBf9hAOVb57l8iTElY7i.ulP2OHSImH3Z52lWGc55aaTSiQ0HKoi',NULL,'2026-03-19 00:19:52','2026-03-19 00:19:52',NULL),
(7,'pedro casanova','pedro@sm.c',NULL,3,'$2y$12$FVdueLXWGXL54GcPBKmU2ugBhO/AJuy2BsOOpGerBHmjUydy5EXzK',NULL,'2026-03-19 01:19:20','2026-03-19 01:19:20',NULL),
(8,'Yonnel Licon','yon@yon123.com',NULL,3,'$2y$12$aEUG8hThseNtgBbP5WC3..ykDOUg.LvdG66SYMj1aFuIcdQMwSRKG',NULL,'2026-03-19 06:21:12','2026-03-19 06:21:12',NULL),
(9,'Yonnel12 Licon','yon1@gmail.com',NULL,3,'$2y$12$xZpz3XcIu4SprBrdtWhrD.KnZssuC7oqGyG3ClhzWV8MNUedpgFFu',NULL,'2026-03-19 06:35:22','2026-03-19 06:35:22',NULL),
(10,'Luis Bolivar','luis@sm.com',NULL,2,'$2y$12$jd8CdHgY33NvHxkTl6VE6.dzQ235P2HQeK34IyH3uog0OVZIsB1km',NULL,'2026-03-17 23:43:14','2026-03-17 23:43:14',NULL),
(11,'Sara Damasco','sara@sm.com',NULL,3,'$2y$12$7tTyYSPrarwyvTFjw30C.eD5nRPY4BzZnv6Mgr989pE6DYybelL7.',NULL,'2026-03-19 11:08:39','2026-03-19 11:08:39',NULL),
(12,'Pepe Alcaravan','pepe@sm.com',NULL,3,'$2y$12$/dosHsreofOestcn6tGbIuU3X7ZI1pqymfb/WY7KWNlTc8F1Tiv8u',NULL,'2026-03-19 11:09:35','2026-03-19 11:09:35',NULL),
(13,'Maria Oropeza','maria@sm.com',NULL,3,'$2y$12$Kiku5sey8eJljB07NAyXiuHGZ27pn1SRrm644SjSTmPL1dAuH.4L.',NULL,'2026-03-19 12:26:57','2026-03-19 12:26:57',NULL),
(14,'Luis Zerpa','luisz@sm.com',NULL,2,'$2y$12$jd8CdHgY33NvHxkTl6VE6.dzQ235P2HQeK34IyH3uog0OVZIsB1km',NULL,'2026-03-17 23:43:14','2026-03-17 23:43:14',NULL),
(16,'Rafa Pedromo','rafa@sm.com',NULL,3,'$2y$12$wndBId.ep9pEpD2YKDq3c.rP5iep2Fq.cmEDWtp72N9kjq7a3lSFK',NULL,'2026-03-19 12:34:11','2026-03-19 12:34:11',NULL),
(17,'Jose Luis','jose@control.com',NULL,8,'$2y$12$QN5XiICt82oNRPmztbrkIOVCnqU3ta/15w3VmnNEsjuLShDfs3AM.',NULL,'2026-03-17 23:43:14','2026-03-24 02:21:45','https://smarthouse-ve.com/V6dsVt232541/'),
(18,'Prueba user','user@control.com',NULL,8,'$2y$12$FqvaCbj.dLxG4jajFMHAueXGpsbr/.T3Q4GRCMW2H2RKj6DFEmLvi',NULL,'2026-03-17 23:43:14','2026-03-24 17:06:30','https://smarthouse-ve.com/Z4rwKp771903/'),
(19,'Yonnel Licon','yonnel@sm.com',NULL,3,'$2y$12$EkghVsJx6UVHZm1u/lq8Tu4tXLfHmXKhlk1qG0nbvlPfwdBx3rGbm',NULL,'2026-03-25 16:37:01','2026-03-25 16:37:01',NULL),
(20,'Prueba1','uno@a.a',NULL,8,'$2y$12$ru1InYpFqva8v3rJmZwgbOwKbBiZddNXYvKN.dYTHWcCafd047ibi',NULL,'2026-03-17 23:43:14','2026-03-25 20:46:04','https://smarthouse-ve.com/jrplks/'),
(22,'Pedro Rasova','owner@a.a',NULL,1,'$2y$12$jd8CdHgY33NvHxkTl6VE6.dzQ235P2HQeK34IyH3uog0OVZIsB1km',NULL,'2026-03-17 23:43:14','2026-03-17 23:43:14',NULL),
(23,'Moises Licon','moises@sm.com',NULL,3,'$2y$12$0fz5l2yr.cC/zcRXnuTPROTToalyTwq1Yc9p/AmpCNG0CC0Sd/jmq',NULL,'2026-03-28 00:24:13','2026-03-28 00:24:13',NULL),
(24,'Yostin Licon','yostin@sm.com',NULL,2,'$2y$12$ohs8Sw2owV5uQRFHGiJhXe.ODjozr9OGregFh.2uOKuabBB6zfbVG',NULL,'2026-03-28 18:46:28','2026-03-28 18:46:28',NULL),
(25,'Ramos Ramos','ramos@sm.com',NULL,3,'$2y$12$TDjTMTJo755BuvWjT7Ek6uPo6cTbR37N0oAOeLoTG6AmsG17cnUB6',NULL,'2026-03-28 19:56:01','2026-03-28 19:56:01',NULL),
(26,'Muffin la bomba Perro','perro@sm.cm',NULL,3,'$2y$12$5XRdAPt0LmS6Tw8jlRQOiOc3mfumQSaDl0dvfmN9PFRvnyXCmVeUm',NULL,'2026-03-29 02:05:10','2026-03-29 02:05:10',NULL),
(27,'Anderson Javier','ander@a.a',NULL,3,'$2y$12$Hk9UMfDQcFHTkhfVKCNMLueMENWHZ8i0UgqDcRLf8Tf16gnGEoXzK',NULL,'2026-04-03 21:59:35','2026-04-03 21:59:35',NULL);
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

-- Dump completed on 2026-04-03 13:38:40
