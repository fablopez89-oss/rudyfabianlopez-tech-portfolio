#!/usr/bin/env bash
# user_audit.sh
# Genera un informe simple de usuarios, sudoers y últimas conexiones
# Uso: sudo ./user_audit.sh

set -euo pipefail
echo "=== Usuarios del sistema ==="
awk -F: '$3>=1000 && $3!=65534 {print $1":"$3":"$6}' /etc/passwd

echo ""
echo "=== Usuarios con sudo (visibles en sudoers) ==="
getent group sudo || true
if [[ -f /etc/sudoers ]]; then
  echo "Contenido /etc/sudoers (líneas no comentadas):"
  grep -E -v '^\s*#' /etc/sudoers || true
fi

echo ""
echo "=== Últimas conexiones (last -n 20) ==="
last -n 20 | head -n 20
