-- Tabla para PoC Web Push
CREATE TABLE IF NOT EXISTS `push_subscriptions` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `device_id` VARCHAR(120) NOT NULL,
  `endpoint` VARCHAR(700) NOT NULL,
  `p256dh` TEXT NOT NULL,
  `auth` TEXT NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_push_endpoint` (`endpoint`),
  KEY `idx_push_device_id` (`device_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
