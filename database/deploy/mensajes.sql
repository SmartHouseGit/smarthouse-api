-- Tabla para /sendMsm y /obtMsm
CREATE TABLE IF NOT EXISTS `mensajes` (
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
