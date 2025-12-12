#!/usr/bin/env bash
# update_system.sh
# Detecta gestor de paquetes (apt, yum/dnf, pacman) y aplica actualización segura
# Uso: sudo ./update_system.sh

set -euo pipefail
if [[ $EUID -ne 0 ]]; then
  echo "Este script debe ejecutarse como root."
  exit 1
fi

if command -v apt >/dev/null 2>&1; then
  echo "Detected apt (Debian/Ubuntu). Actualizando..."
  apt update && apt -y upgrade && apt -y autoremove
elif command -v dnf >/dev/null 2>&1; then
  echo "Detected dnf (Fedora/CentOS Stream/RHEL). Actualizando..."
  dnf -y upgrade
elif command -v yum >/dev/null 2>&1; then
  echo "Detected yum (CentOS/RHEL). Actualizando..."
  yum -y update
elif command -v pacman >/dev/null 2>&1; then
  echo "Detected pacman (Arch). Actualizando..."
  pacman -Syu --noconfirm
else
  echo "No se detectó un gestor de paquetes soportado. Abortando."
  exit 2
fi

echo "Actualización finalizada."
