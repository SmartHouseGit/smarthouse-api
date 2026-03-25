-- Agrega relacion usuario <-> push_notifications en instalaciones existentes

SET @has_col := (
  SELECT COUNT(*)
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'push_notifications'
    AND COLUMN_NAME = 'user_id'
);
SET @sql := IF(
  @has_col = 0,
  'ALTER TABLE `push_notifications` ADD COLUMN `user_id` BIGINT UNSIGNED NULL AFTER `id`',
  'SELECT 1'
);
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @has_idx := (
  SELECT COUNT(*)
  FROM INFORMATION_SCHEMA.STATISTICS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'push_notifications'
    AND INDEX_NAME = 'idx_push_notifications_user'
);
SET @sql := IF(
  @has_idx = 0,
  'ALTER TABLE `push_notifications` ADD KEY `idx_push_notifications_user` (`user_id`)',
  'SELECT 1'
);
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @has_fk := (
  SELECT COUNT(*)
  FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS
  WHERE CONSTRAINT_SCHEMA = DATABASE()
    AND TABLE_NAME = 'push_notifications'
    AND CONSTRAINT_NAME = 'fk_push_notifications_user'
);
SET @sql := IF(
  @has_fk = 0,
  'ALTER TABLE `push_notifications` ADD CONSTRAINT `fk_push_notifications_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE ON DELETE SET NULL',
  'SELECT 1'
);
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- Completa user_id para pendientes existentes con id_owner del prestamo (si aplica)
UPDATE `push_notifications` pn
JOIN `loans` l ON l.id = pn.loan_id
SET pn.user_id = l.id_owner
WHERE pn.user_id IS NULL
  AND l.id_owner IS NOT NULL;
