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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
(5,5,4,NULL,NULL,'Luis','Mora','+584149998877','Asesor inmobiliario'),
(6,6,4,NULL,NULL,'Raul','de Cervantes','+584243659965','buen vendedor'),
(7,7,4,NULL,NULL,'pedro','casanova','42566956856','Prof'),
(8,8,4,NULL,NULL,'Yonnel','Licon','04126789078','Yonnel'),
(9,9,4,NULL,NULL,'Yonnel12','Licon','041256789098','Yonnel Moises'),
(11,11,10,NULL,NULL,'Sara','Damasco','+584243073815','Buen Agente'),
(12,12,10,NULL,NULL,'Pepe','Alcaravan','+584243073956','Mejor Agenmte'),
(13,13,10,NULL,NULL,'Maria','Oropeza','+5755656584547','Sin notas add'),
(16,16,14,NULL,NULL,'Rafa','Pedromo','+58424665845','prueba'),
(19,19,4,NULL,NULL,'Yonnel','Licon','041238238213','Vendedor informal');
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
('laravel-cache-illuminate:queue:restart','i:1774315216;',2089675216),
('laravel-cache-login|admin@a.a|104.23.245.6','i:1;',1774456516),
('laravel-cache-login|admin@a.a|104.23.245.6:timer','i:1774456516;',1774456516),
('laravel-cache-login|admin@a.a|172.68.7.154','i:1;',1774440115),
('laravel-cache-login|admin@a.a|172.68.7.154:timer','i:1774440115;',1774440115),
('laravel-cache-login|admin|172.64.222.53','i:3;',1774317250),
('laravel-cache-login|admin|172.64.222.53:timer','i:1774317250;',1774317250),
('laravel-cache-login|admin|172.70.111.163','i:1;',1774315437),
('laravel-cache-login|admin|172.70.111.163:timer','i:1774315437;',1774315437),
('laravel-cache-login|admin|172.70.111.164','i:1;',1774315427),
('laravel-cache-login|admin|172.70.111.164:timer','i:1774315427;',1774315427),
('laravel-cache-login|jose@control.com|172.68.12.50','i:5;',1774315358),
('laravel-cache-login|jose@control.com|172.68.12.50:timer','i:1774315358;',1774315358),
('laravel-cache-login|jose@control.com|172.68.12.51','i:1;',1774315422),
('laravel-cache-login|jose@control.com|172.68.12.51:timer','i:1774315422;',1774315422),
('laravel-cache-login|jose@control.com|172.70.111.164','i:2;',1774315448),
('laravel-cache-login|jose@control.com|172.70.111.164:timer','i:1774315448;',1774315448),
('laravel-cache-login|owner@a.com|172.70.83.153','i:1;',1774440068),
('laravel-cache-login|owner@a.com|172.70.83.153:timer','i:1774440068;',1774440068),
('laravel-cache-login|owner@sm.com|108.162.212.123','i:1;',1774440075),
('laravel-cache-login|owner@sm.com|108.162.212.123:timer','i:1774440075;',1774440075),
('laravel-cache-login|owner@sm.com|172.70.55.196','i:1;',1774440051),
('laravel-cache-login|owner@sm.com|172.70.55.196:timer','i:1774440051;',1774440051),
('laravel-cache-login|owner@smarthouse.local|162.158.62.206','i:1;',1774398978),
('laravel-cache-login|owner@smarthouse.local|162.158.62.206:timer','i:1774398978;',1774398978),
('laravel-cache-login|owner@smarthouse.local|172.70.111.163','i:1;',1774398978),
('laravel-cache-login|owner@smarthouse.local|172.70.111.163:timer','i:1774398978;',1774398978),
('laravel-cache-login|raulsm@a.a|172.68.7.135','i:1;',1774410619),
('laravel-cache-login|raulsm@a.a|172.68.7.135:timer','i:1774410619;',1774410619),
('laravel-cache-login|user@control.com|104.23.248.25','i:1;',1774365657),
('laravel-cache-login|user@control.com|104.23.248.25:timer','i:1774365657;',1774365657),
('laravel-cache-login|user@control.com|172.68.12.50','i:1;',1774456900),
('laravel-cache-login|user@control.com|172.68.12.50:timer','i:1774456900;',1774456900),
('laravel-cache-login|yon@a.a|172.68.12.50','i:2;',1774410647),
('laravel-cache-login|yon@a.a|172.68.12.50:timer','i:1774410647;',1774410647),
('laravel-cache-login|yon@a.a|172.68.7.134','i:1;',1774410649),
('laravel-cache-login|yon@a.a|172.68.7.134:timer','i:1774410649;',1774410649),
('laravel-cache-login|yon@a.a|172.68.7.135','i:1;',1774410661),
('laravel-cache-login|yon@a.a|172.68.7.135:timer','i:1774410661;',1774410661),
('laravel-cache-login|yon@a.a|172.70.255.67','i:2;',1774410659),
('laravel-cache-login|yon@a.a|172.70.255.67:timer','i:1774410659;',1774410659),
('laravel-cache-login|yon@a.a|172.70.255.68','i:1;',1774410601),
('laravel-cache-login|yon@a.a|172.70.255.68:timer','i:1774410601;',1774410601),
('laravel-cache-login|yon@a.a|172.70.55.195','i:1;',1774410594),
('laravel-cache-login|yon@a.a|172.70.55.195:timer','i:1774410594;',1774410594),
('laravel-cache-login|yon@a.a|172.70.83.153','i:1;',1774410651),
('laravel-cache-login|yon@a.a|172.70.83.153:timer','i:1774410651;',1774410651),
('laravel-cache-login|yon@sm.com|104.23.248.25','i:1;',1774443921),
('laravel-cache-login|yon@sm.com|104.23.248.25:timer','i:1774443921;',1774443921),
('laravel-cache-login|yon@sm.com|172.68.12.51','i:1;',1774440142),
('laravel-cache-login|yon@sm.com|172.68.12.51:timer','i:1774440142;',1774440142),
('laravel-cache-login|yonsm@a.a|104.23.248.25','i:1;',1774410610),
('laravel-cache-login|yonsm@a.a|104.23.248.25:timer','i:1774410610;',1774410610);
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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
(11,'clientes/LNrXGTaa2psJWJX5z14vvrCpleulHawrCipkw3sc.jpg','clientes/QdSSEsAUI6ermDCvmJEzoev0cV755VUm9tKEnpJ8.jpg','CLiente 6','prueba','Comprador','Activo','654984864646','cliente6@sm.com','sffefwe','Valencia','4816498','sin nota',12),
(12,'clientes/TIgvn3MQNJqVQ4jxL7jbiZrnJ00ULXpCduFiOu38.png','clientes/kf3hWKsiP00lQUga9X7UDsYPiozupxhePwUxjePN.png','Ranso','Comprador premium','Comprador','Nuevo','041223823993','rank@1.com','Altamira','Caracas','373782829','Comprador',6),
(13,'clientes/aTYwqiAiUU1Ogh8HSeRezqDx7vi8QaQgwRr0tdR5.jpg','clientes/5yoGk14RQtbjyb2dk6yMUaeqRVXxy13UwvuSchnZ.png','Reis','Comprador inversionista','Corporativo','Nuevo','0412482948','yonn@a.com','Su casa','Villa de cura','38213812','Casita',6);
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
) ENGINE=InnoDB AUTO_INCREMENT=163 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
(50,11,3,'2026-06-23','2026-06-23',11000.00,0.00,11000.00,'paid',NULL,'loans/proofs/2QgPsP3kfdH4jld2jJjZAPc8cLzxOL2KQaoTTvoZ.png','2026-03-23 21:01:52','2026-03-23 21:01:32','2026-03-23 21:01:52'),
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
(162,28,12,'2027-04-01','2027-04-01',6060.00,0.00,6060.00,'pending',NULL,NULL,NULL,'2026-03-24 21:36:21','2026-03-24 21:36:21');
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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
(11,'kkjhkhkhkj','kjhkkjhkhk',10000.00,'mensual',3,10.0000,1000.00,11000.00,3000.00,13000.00,'2026-03-23','2026-06-23','completed',NULL,NULL,'2026-03-23 21:01:32','2026-03-23 21:01:52'),
(23,'Gaby Kalach','15609471',50000.00,'mensual',2,2.0000,1000.00,51000.00,2000.00,52000.00,'2026-03-03','2026-05-03','active',17,17,'2026-03-24 02:32:52','2026-03-24 02:32:52'),
(24,'Adrián Proautos','11922250',10000.00,'mensual',12,5.0000,500.00,10500.00,6000.00,16000.00,'2026-01-01','2027-01-01','active',17,17,'2026-03-24 02:36:59','2026-03-24 02:36:59'),
(25,'Juan Carlos','13345777',1500.00,'mensual',36,1.0000,15.00,1515.00,540.00,2040.00,'2025-01-07','2028-01-07','active',17,17,'2026-03-24 03:18:11','2026-03-24 03:18:11'),
(26,'Jeiver Victora','25662184',80000.00,'mensual',9,7.0000,5600.00,85600.00,50400.00,130400.00,'2026-03-07','2026-12-07','active',17,17,'2026-03-24 10:32:40','2026-03-24 10:32:40'),
(27,'Carlos Gaviria','19531106',30000.00,'mensual',3,10.0000,3000.00,33000.00,9000.00,39000.00,'2026-03-07','2026-06-07','active',17,17,'2026-03-24 10:36:08','2026-03-24 19:56:10'),
(28,'Freddy Arguello','18230702',6000.00,'mensual',12,1.0000,60.00,6060.00,720.00,6720.00,'2026-04-01','2027-04-01','active',17,17,'2026-03-24 21:36:21','2026-03-24 21:36:21');
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
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
(41,'App\\Models\\User',18,'frontend','64676c0f2bc6508c9e50abc86ee23830163f66e87df7a89e017c17dc8b2b9328','[\"*\"]','2026-03-24 01:32:39',NULL,'2026-03-24 01:28:47','2026-03-24 01:32:39'),
(42,'App\\Models\\User',18,'frontend','528842d3059f90606d856998b5f286c65ca49665ff4f8bba5e856deb5b3f2cbf','[\"*\"]','2026-03-24 01:41:02',NULL,'2026-03-24 01:39:56','2026-03-24 01:41:02'),
(43,'App\\Models\\User',18,'frontend','3f8c52196d7698c331ca9736ec31cbe06fd0f9cee2330bc06c64a04b75187aa7','[\"*\"]','2026-03-24 01:41:11',NULL,'2026-03-24 01:41:10','2026-03-24 01:41:11'),
(44,'App\\Models\\User',17,'frontend','40e4146bc24dc027410d8d9efc7468e8c555786b0d4ab5b70b7a2ec1ce99bec3','[\"*\"]','2026-03-25 17:54:53',NULL,'2026-03-24 01:54:24','2026-03-25 17:54:53'),
(45,'App\\Models\\User',18,'frontend','ab341ea52ac394af25d8e0b265a4f902b05b9cdbf03b6053ebfd509f24d6caaf','[\"*\"]','2026-03-25 20:40:11',NULL,'2026-03-24 14:29:56','2026-03-25 20:40:11'),
(46,'App\\Models\\User',18,'frontend','75876de5881f456e4a4bbe49e8b13dba0c781b449d1635d4a44835f42081080d','[\"*\"]','2026-03-24 15:15:12',NULL,'2026-03-24 15:15:12','2026-03-24 15:15:12'),
(47,'App\\Models\\User',18,'frontend','91dbbb09c1b33ab147a633265a3c087e31df98d59789f15c145632ad129d3395','[\"*\"]','2026-03-24 17:06:39',NULL,'2026-03-24 15:20:18','2026-03-24 17:06:39'),
(48,'App\\Models\\User',18,'frontend','d63e7986cbf9fa0323c08bd464aacb87940c853d861e7ccafa6bd5d7d5254139','[\"*\"]','2026-03-24 17:07:04',NULL,'2026-03-24 17:07:04','2026-03-24 17:07:04'),
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
(84,'App\\Models\\User',4,'frontend','5d5b6fec74e4423a48bf0c6b1dadfc7e7cf6bb5c6ad7bf5b312783a82274a5db','[\"*\"]','2026-03-25 20:38:30',NULL,'2026-03-25 20:34:22','2026-03-25 20:38:30');
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `propiedades`
--

LOCK TABLES `propiedades` WRITE;
/*!40000 ALTER TABLE `propiedades` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `propiedades` VALUES
(1,'PUB-0001','Residencias El Bosque','Residencias El Bosque','Valencia, Carabobo','Apartamento',125000.00,'disponible','publicado','Apartamento en excelente zona, cerca de centros comerciales.','{\"dormitorios\":3,\"banos\":2,\"area_m2\":110,\"estacionamientos\":2,\"con_piscina\":true,\"pet_friendly\":true,\"ano_construccion\":2018,\"amoblada\":false,\"balcon\":true,\"seguridad_privada\":true,\"financiable\":true}',11,6,10.1620000,-68.0077000,'https://mi-cdn.com/propiedades/p-1-main.jpg','[\"https://mi-cdn.com/propiedades/p-1-2.jpg\",\"https://mi-cdn.com/propiedades/p-1-3.jpg\"]'),
(2,'PUB-0002','Casa Los Naranjos','Casa Los Naranjos','Caracas, Distrito Capital','Casa',185000.00,'disponible','publicado','Casa de dos niveles, remodelada, con buena ventilacion.','{\"dormitorios\":4,\"banos\":3,\"area_m2\":220,\"estacionamientos\":2,\"con_piscina\":false,\"pet_friendly\":true,\"ano_construccion\":2012,\"amoblada\":false,\"balcon\":true,\"seguridad_privada\":true,\"financiable\":true}',11,7,10.4806000,-66.9036000,'https://mi-cdn.com/propiedades/p-2-main.jpg','[\"https://mi-cdn.com/propiedades/p-2-2.jpg\",\"https://mi-cdn.com/propiedades/p-2-3.jpg\"]'),
(3,'PUB-0003','Yonaj','En venta','Caracas','Apartamento',12500.00,'disponible','publicado','Holas','{\"dormitorios\":0,\"banos\":0,\"area_m2\":0,\"estacionamientos\":0,\"con_piscina\":false,\"pet_friendly\":false,\"ano_construccion\":2026,\"amoblada\":false,\"balcon\":false,\"seguridad_privada\":true,\"financiable\":false}',6,4,10.5060930,-66.9146010,'propiedades/r1CDmlebBjkaYed0wo5e0T3wjvCLzNGSW5AZAbim.png','[\"propiedades\\/cZ9FmtlTvtA9ZgWqTkdF5c1l7jqYISda4NJdueKc.jpg\"]'),
(4,'PUB-0004','Casa prueba','En venta','Carabobo','Apartamento',13000.00,'disponible','publicado','Casa moderna','{\"dormitorios\":3,\"banos\":3,\"area_m2\":200,\"estacionamientos\":2,\"con_piscina\":false,\"pet_friendly\":false,\"ano_construccion\":2026,\"amoblada\":false,\"balcon\":false,\"seguridad_privada\":true,\"financiable\":false}',6,NULL,10.1700260,-68.0003990,'propiedades/Tnwn6JDAajJTNKlgMsEVV08YxQKnmnNkjXKbaray.png','[\"propiedades\\/EbcpgCJUrSHsyH6Owq9SCkRpIOijlTJwrCkIqw1T.jpg\"]'),
(5,'PUB-0005','Casssa','En venta','Cagua','Casa',12000.00,'disponible','publicado','Casa preciosa','{\"dormitorios\":2,\"banos\":2,\"area_m2\":200,\"estacionamientos\":2,\"con_piscina\":false,\"pet_friendly\":false,\"ano_construccion\":2026,\"amoblada\":false,\"balcon\":false,\"seguridad_privada\":true,\"financiable\":false}',19,NULL,10.1796630,-67.4606770,'propiedades/flcuWQUcm8F8YcF0tPKFQfRtqtAa36TtVN2KjX3l.jpg','[\"propiedades\\/26X4ABjOGHxvf22qDrdCDcrkkpT2GccvkoMZUs3H.png\"]');
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
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `push_notifications`
--

LOCK TABLES `push_notifications` WRITE;
/*!40000 ALTER TABLE `push_notifications` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `push_notifications` VALUES
(72,NULL,5,21,'due_hourly','2026-03-24',21,'cut:21:due_hourly:2026-03-24:21','Corte con vencimiento hoy','Prueba: hoy vence tu corte de 350.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=5&cutId=21','loan-due-today-cut-21-h21','2026-03-24 21:00:00','sent',1,0,0,0,'2026-03-24 21:00:02',NULL,'2026-03-24 21:00:02','2026-03-24 21:00:02'),
(73,NULL,5,21,'due_hourly','2026-03-24',22,'cut:21:due_hourly:2026-03-24:22','Corte con vencimiento hoy','Prueba: hoy vence tu corte de 350.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=5&cutId=21','loan-due-today-cut-21-h22','2026-03-24 22:00:00','sent',1,0,0,0,'2026-03-24 22:00:02',NULL,'2026-03-24 22:00:02','2026-03-24 22:00:02'),
(74,NULL,5,21,'due_hourly','2026-03-24',23,'cut:21:due_hourly:2026-03-24:23','Corte con vencimiento hoy','Prueba: hoy vence tu corte de 350.00.','https://smarthouse-ve.com/V6dsVt232541/?view=history&loanId=5&cutId=21','loan-due-today-cut-21-h23','2026-03-24 23:00:00','sent',1,0,0,0,'2026-03-24 23:00:01',NULL,'2026-03-24 23:00:01','2026-03-24 23:00:01');
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `push_subscriptions`
--

LOCK TABLES `push_subscriptions` WRITE;
/*!40000 ALTER TABLE `push_subscriptions` DISABLE KEYS */;
set autocommit=0;
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
(9,'todos','2026-03-27','09:00:00','oficina',NULL,'todos',6,0,NULL),
(10,'todos','2026-03-27','09:00:00','oficina',NULL,'todos',156,0,NULL),
(11,'todos','2026-03-27','09:00:00','oficina',NULL,'todos',5,0,NULL),
(12,'todos','2026-03-27','09:00:00','oficina',NULL,'todos',7,0,NULL),
(13,'todos','2026-03-30','09:00:00','oficina',NULL,'todos\nReprogramada: Necesario',19,0,'reprogramada'),
(14,'todos','2026-03-27','09:00:00','oficina',NULL,'todos',9,0,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rutas`
--

LOCK TABLES `rutas` WRITE;
/*!40000 ALTER TABLE `rutas` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `rutas` VALUES
(1,4,'Test','08:30:00','12:30:00','[\"la arboleda\",\"el valle\",\"cualquier cosa\"]','{\"lat\":10.187529,\"lng\":-64.634298}','[\"volantes entregados\",\"Visitas\",\"Muestras\"]',NULL,'[{\"id_agente\":19,\"requisito\":\"volantes entregados\",\"resultado\":\"10\"},{\"id_agente\":19,\"requisito\":\"Visitas\",\"resultado\":\"12\"},{\"id_agente\":19,\"requisito\":\"Muestras\",\"resultado\":\"5\"}]','todo bien'),
(2,4,'Maracay','08:30:00','12:30:00','[\"Maracay\",\"Urbanizaci\\u00f3n el centro\"]','{\"lat\":10.236058,\"lng\":-67.59797}','[\"Casas\",\"apartamentos\"]',NULL,NULL,NULL);
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
('8Lda2d2x8XmAAALhLLISR5pYpmXSAu2yvhVYa7pw',NULL,'104.23.221.109','Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:123.0) Gecko/20100101 Firefox/123','YTozOntzOjY6Il90b2tlbiI7czo0MDoiQU5wV0g3S2ZMSE53bHlLWWh2bHFWU2RXNDJqNVVrZmFYRnFNdDBPaSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjozZXBoOUtweFlTNTdlSGhxIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1774452796),
('ElcTIhQBu6qOLKO34JmYNgpNNMGbYoOJpEkigGxX',NULL,'172.69.86.240','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoicjdEaFJzZDhsRDF4dUE3TG1JaUlrOWg1WDNmWkdjZXc3eHV0bXdHOCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjozZXBoOUtweFlTNTdlSGhxIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1774447245),
('grcr84HJDe3uF3YAPyjB3VSFlrUWLjNdTFn02WPO',NULL,'172.71.95.90','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1','YTozOntzOjY6Il90b2tlbiI7czo0MDoieWl1cFU3VGNLcHc2SEhvNko4SU5mM2FDbndmVVdjSnlzNW5tVDJRcyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjozZXBoOUtweFlTNTdlSGhxIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1774453917),
('i4Vqpds5iUm5sv2wyuaWv7m5tMg8h32S2ElsqJuO',NULL,'172.69.176.123','Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1','YTozOntzOjY6Il90b2tlbiI7czo0MDoiV2lzZWlrVnlXRXBNR3pGeDY5WlB0emQwSFRaVzlIdnlSd0lvRGljUyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjozZXBoOUtweFlTNTdlSGhxIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1774443411),
('KpPUu4e5zOIEK4m27P99LV6bFrvY8ZrJPgT0s08i',NULL,'162.158.178.161','Mozilla/5.0 (Android 11; Mobile; rv:128.4.0) Gecko/128.4.0 Firefox/128.4.0','YTozOntzOjY6Il90b2tlbiI7czo0MDoiMU80REJjU0NXUnVhS24zRWZMTkU5SkZyOUswU25MVjVvV1haTjM5SiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjozZXBoOUtweFlTNTdlSGhxIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1774440417),
('PVwkkxV2p8ZN4znMm3GYhmu361WrA3g2XDTxRZqT',NULL,'172.70.127.148','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiVlNHSjc4Tm5iQ3RQaXRpaFQ3R1pYd1FNcVFuazc2WldnSkI0TlF4MiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjozZXBoOUtweFlTNTdlSGhxIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1774447338),
('yGbZtAqC0oVTFF37bxnUSFTCV60VZt45gXzWSraz',NULL,'172.71.103.171','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiR0tTNHdzTU9oYTJPdHNKeDNHdGpyNTRQMFQzV0RMb1dKSjREbk5jRiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjozZXBoOUtweFlTNTdlSGhxIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1774441235),
('ZUs7AciTn5JZZOPjvlm6sNXcIbKxN6LAc4Dbwxnn',NULL,'172.69.214.41','Mozilla/5.0 (compatible; AhrefsBot/7.0; +http://ahrefs.com/robot/)','YTozOntzOjY6Il90b2tlbiI7czo0MDoiNEsxN1V0bk5xZWtSd3VMN000VzB2aFc3aFh4QnBtOW5QTHF2blpCWiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vazdwcjJ3bjl4bTR0YjZ2bDF6cTguaW5mbyI7czo1OiJyb3V0ZSI7czoyNzoiZ2VuZXJhdGVkOjozZXBoOUtweFlTNTdlSGhxIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1774456622);
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
  `url` varchar(254) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
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
(17,'Jose Luis','jose@control.com',NULL,8,'$2y$12$QN5XiICt82oNRPmztbrkIOVCnqU3ta/15w3VmnNEsjuLShDfs3AM.',NULL,'2026-03-17 23:43:14','2026-03-24 02:21:45',NULL),
(18,'Prueba user','user@control.com',NULL,8,'$2y$12$FqvaCbj.dLxG4jajFMHAueXGpsbr/.T3Q4GRCMW2H2RKj6DFEmLvi',NULL,'2026-03-17 23:43:14','2026-03-24 17:06:30',NULL),
(19,'Yonnel Licon','yonnel@sm.com',NULL,3,'$2y$12$EkghVsJx6UVHZm1u/lq8Tu4tXLfHmXKhlk1qG0nbvlPfwdBx3rGbm',NULL,'2026-03-25 16:37:01','2026-03-25 16:37:01',NULL);
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

-- Dump completed on 2026-03-25 11:43:32
