#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

if [[ ! -f "scripts/generate-db-dump.sh" ]]; then
  echo "No existe scripts/generate-db-dump.sh" >&2
  exit 1
fi

echo "Generando dump SQL local..."
bash scripts/generate-db-dump.sh

echo "Agregando cambios con git add..."
git add .

if git diff --cached --quiet; then
  echo "No hay cambios para commitear."
  exit 0
fi

read -r -p "Escribe el mensaje del commit: " COMMIT_MESSAGE

if [[ -z "${COMMIT_MESSAGE// }" ]]; then
  echo "El mensaje del commit no puede estar vacio." >&2
  exit 1
fi

echo "Creando commit..."
git commit -m "$COMMIT_MESSAGE"

CURRENT_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
echo "Haciendo push a origin/$CURRENT_BRANCH..."
git push origin "$CURRENT_BRANCH"

echo "Proceso completado."
