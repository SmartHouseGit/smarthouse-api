-- Tabla para endpoint /setRuta, /updRuta y /obtRutas
CREATE TABLE IF NOT EXISTS `rutas` (
  `id_ruta` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ref` bigint(20) unsigned NOT NULL,
  `zona` varchar(180) NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_final` time NOT NULL,
  `sectores` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`sectores`)),
  `ubicacion_inicial` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`ubicacion_inicial`)),
  `recaudos` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`recaudos`)),
  `agentes` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (`agentes` IS NULL OR json_valid(`agentes`)),
  `resultados` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (`resultados` IS NULL OR json_valid(`resultados`)),
  `notas` text DEFAULT NULL,
  PRIMARY KEY (`id_ruta`),
  KEY `idx_rutas_ref` (`ref`),
  KEY `idx_rutas_zona` (`zona`),
  CONSTRAINT `fk_rutas_users_ref` FOREIGN KEY (`ref`) REFERENCES `users` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
