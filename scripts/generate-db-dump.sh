#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ENV_FILE="${1:-$ROOT_DIR/.env}"
OUTPUT_FILE="${2:-$ROOT_DIR/database/deploy/temp.sql}"
ONLY_STRUCTURE="${ONLY_STRUCTURE:-0}"

if [[ ! -f "$ENV_FILE" ]]; then
  echo "No se encontro archivo de entorno: $ENV_FILE" >&2
  exit 1
fi

if ! command -v mysqldump >/dev/null 2>&1; then
  echo "mysqldump no esta instalado en este entorno." >&2
  exit 1
fi

env_value() {
  local key="$1"
  local default_value="${2:-}"
  local value
  value="$(grep -m1 "^${key}=" "$ENV_FILE" | cut -d= -f2- || true)"
  value="${value%\"}"
  value="${value#\"}"

  if [[ -z "$value" ]]; then
    echo "$default_value"
  else
    echo "$value"
  fi
}

DB_CONNECTION="$(env_value DB_CONNECTION mysql)"
DB_HOST="$(env_value DB_HOST 127.0.0.1)"
DB_PORT="$(env_value DB_PORT 3306)"
DB_DATABASE="$(env_value DB_DATABASE)"
DB_USERNAME="$(env_value DB_USERNAME root)"
DB_PASSWORD="$(env_value DB_PASSWORD)"

if [[ "$DB_CONNECTION" != "mysql" ]]; then
  echo "Este script solo soporta DB_CONNECTION=mysql. Valor actual: $DB_CONNECTION" >&2
  exit 1
fi

if [[ -z "$DB_DATABASE" ]]; then
  echo "DB_DATABASE esta vacio en $ENV_FILE" >&2
  exit 1
fi

mkdir -p "$(dirname "$OUTPUT_FILE")"

DUMP_ARGS=(
  "--host=$DB_HOST"
  "--port=$DB_PORT"
  "--user=$DB_USERNAME"
  "--single-transaction"
  "--routines"
  "--triggers"
  "--default-character-set=utf8mb4"
  "$DB_DATABASE"
)

if [[ "$ONLY_STRUCTURE" == "1" ]]; then
  DUMP_ARGS=("--no-data" "${DUMP_ARGS[@]}")
fi

if [[ -n "$DB_PASSWORD" ]]; then
  MYSQL_PWD="$DB_PASSWORD" mysqldump "${DUMP_ARGS[@]}" > "$OUTPUT_FILE"
else
  mysqldump "${DUMP_ARGS[@]}" > "$OUTPUT_FILE"
fi

if [[ ! -s "$OUTPUT_FILE" ]]; then
  echo "El dump fue generado vacio: $OUTPUT_FILE" >&2
  exit 1
fi

echo "Dump generado correctamente: $OUTPUT_FILE"
