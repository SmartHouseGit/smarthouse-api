-- Tabla singleton para /setConfig y /obtConfig
CREATE TABLE IF NOT EXISTS `configs` (
  `id_config` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `hero_frase` text DEFAULT NULL,
  `hero_imagen` varchar(500) DEFAULT NULL,
  `micelines` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (`micelines` IS NULL OR json_valid(`micelines`)),
  `destacados` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (`destacados` IS NULL OR json_valid(`destacados`)),
  `banner` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (`banner` IS NULL OR json_valid(`banner`)),
  `comentarios` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (`comentarios` IS NULL OR json_valid(`comentarios`)),
  PRIMARY KEY (`id_config`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
