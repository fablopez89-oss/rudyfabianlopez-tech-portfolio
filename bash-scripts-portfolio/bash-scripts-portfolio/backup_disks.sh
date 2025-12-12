#!/usr/bin/env bash
# backup_disks.sh
# Realiza backup de rutas/particiones usando rsync o tar (según prefiera)
# Uso: sudo ./backup_disks.sh /origen /destino [--rsync|--tar]

set -euo pipefail
if [[ $EUID -ne 0 ]]; then
  echo "Se recomienda ejecutar como root para respaldar todo el sistema."
fi

ORIG="${1:-/}"
DEST="${2:-/backup}"
MODE="${3:---rsync}"

TIMESTAMP=$(date +%Y%m%d-%H%M%S)
mkdir -p "$DEST"

if [[ "$MODE" == "--rsync" ]]; then
  echo "Iniciando rsync desde $ORIG a $DEST/rsync-$TIMESTAMP"
  rsync -aAXv --delete --exclude={"/proc/*","/sys/*","/dev/*","/run/*","/tmp/*","/mnt/*","/lost+found"} "$ORIG" "$DEST/rsync-$TIMESTAMP/"
  echo "Backup rsync completado."
else
  TARFILE="$DEST/backup-$(basename $ORIG)-$TIMESTAMP.tar.gz"
  echo "Creando tar.gz en $TARFILE (excluyendo /proc /sys /dev /run /tmp /mnt)"
  tar --exclude=/proc --exclude=/sys --exclude=/dev --exclude=/run --exclude=/tmp --exclude=/mnt -czpf "$TARFILE" -C "$ORIG" .
  echo "Backup tar completado."
fi

echo "Backups disponibles en $DEST"
