-- Agrega relacion usuario <-> push_subscriptions en instalaciones existentes

SET @has_col := (
  SELECT COUNT(*)
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'push_subscriptions'
    AND COLUMN_NAME = 'user_id'
);
SET @sql := IF(
  @has_col = 0,
  'ALTER TABLE `push_subscriptions` ADD COLUMN `user_id` BIGINT UNSIGNED NULL AFTER `id`',
  'SELECT 1'
);
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @has_idx := (
  SELECT COUNT(*)
  FROM INFORMATION_SCHEMA.STATISTICS
  WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'push_subscriptions'
    AND INDEX_NAME = 'idx_push_user_id'
);
SET @sql := IF(
  @has_idx = 0,
  'ALTER TABLE `push_subscriptions` ADD KEY `idx_push_user_id` (`user_id`)',
  'SELECT 1'
);
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @has_fk := (
  SELECT COUNT(*)
  FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS
  WHERE CONSTRAINT_SCHEMA = DATABASE()
    AND TABLE_NAME = 'push_subscriptions'
    AND CONSTRAINT_NAME = 'fk_push_subscriptions_user'
);
SET @sql := IF(
  @has_fk = 0,
  'ALTER TABLE `push_subscriptions` ADD CONSTRAINT `fk_push_subscriptions_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE ON DELETE SET NULL',
  'SELECT 1'
);
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
