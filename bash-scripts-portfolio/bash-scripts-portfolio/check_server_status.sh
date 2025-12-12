#!/usr/bin/env bash
# check_server_status.sh
# Verifica si un host está arriba (ping) y verifica servicios via systemctl
# Uso: ./check_server_status.sh <host> [service1 service2 ...]

set -euo pipefail
HOST="${1:-localhost}"
shift || true

echo "Comprobando conectividad con $HOST..."
if ping -c 3 "$HOST" &>/dev/null; then
  echo "Host $HOST reachable (ping OK)"
else
  echo "Host $HOST NO responde (ping falló)"
fi

if [[ $# -gt 0 ]]; then
  echo ""
  echo "Comprobando servicios via systemctl (requiere acceso remoto o ejecución local)..."
  for svc in "$@"; do
    if systemctl is-active --quiet "$svc"; then
      echo "Servicio $svc: active"
    else
      echo "Servicio $svc: NOT active"
    fi
  done
fi
