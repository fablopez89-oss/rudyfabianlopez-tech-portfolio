#!/usr/bin/env bash
# deploy_example.sh
# Script de despliegue simple: clona repo, instala dependencias y reinicia servicio systemd
# Uso: ./deploy_example.sh <git-repo-url> <deploy-dir> <service-name>

set -euo pipefail
REPO="${1:-}"
DEPLOY_DIR="${2:-/opt/app}"
SERVICE="${3:-myapp.service}"

if [[ -z "$REPO" ]]; then
  echo "Uso: $0 <git-repo-url> <deploy-dir> <service-name>"
  exit 1
fi

echo "Clonando $REPO en $DEPLOY_DIR..."
rm -rf "$DEPLOY_DIR"
git clone "$REPO" "$DEPLOY_DIR"

if [[ -f "$DEPLOY_DIR/requirements.txt" ]]; then
  echo "Instalando dependencias ( Python )"
  if command -v pip3 >/dev/null 2>&1; then
    pip3 install -r "$DEPLOY_DIR/requirements.txt"
  fi
fi

echo "Reiniciando servicio systemd: $SERVICE"
if systemctl list-units --full -all | grep -q "$SERVICE"; then
  systemctl restart "$SERVICE"
  echo "Servicio reiniciado."
else
  echo "Servicio $SERVICE no existe en systemd. Despliegue completado sin restart."
fi
