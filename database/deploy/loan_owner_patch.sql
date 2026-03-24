-- Patch para entorno existente: agrega id_owner en loans y lo vincula a users.id

SET @schema_name := DATABASE();

-- 1) Columna id_owner
SET @sql := IF(
  (SELECT COUNT(*)
   FROM information_schema.COLUMNS
   WHERE TABLE_SCHEMA = @schema_name
     AND TABLE_NAME = 'loans'
     AND COLUMN_NAME = 'id_owner') = 0,
  'ALTER TABLE loans ADD COLUMN id_owner BIGINT UNSIGNED NULL AFTER status',
  'SELECT "id_owner ya existe"'
);
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 2) Backfill desde created_by_user_id
UPDATE loans
SET id_owner = created_by_user_id
WHERE id_owner IS NULL
  AND created_by_user_id IS NOT NULL;

-- 3) Indice en id_owner
SET @sql := IF(
  (SELECT COUNT(*)
   FROM information_schema.STATISTICS
   WHERE TABLE_SCHEMA = @schema_name
     AND TABLE_NAME = 'loans'
     AND INDEX_NAME = 'idx_loans_owner') = 0,
  'ALTER TABLE loans ADD KEY idx_loans_owner (id_owner)',
  'SELECT "idx_loans_owner ya existe"'
);
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 4) FK id_owner -> users.id
SET @sql := IF(
  (SELECT COUNT(*)
   FROM information_schema.TABLE_CONSTRAINTS
   WHERE TABLE_SCHEMA = @schema_name
     AND TABLE_NAME = 'loans'
     AND CONSTRAINT_NAME = 'fk_loans_users_owner') = 0,
  'ALTER TABLE loans ADD CONSTRAINT fk_loans_users_owner FOREIGN KEY (id_owner) REFERENCES users(id) ON UPDATE CASCADE ON DELETE SET NULL',
  'SELECT "fk_loans_users_owner ya existe"'
);
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
