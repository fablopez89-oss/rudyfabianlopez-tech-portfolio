#!/usr/bin/env bash
# rotate_logs.sh
# Rotación simple de logs por tamaño o antigüedad (no reemplaza logrotate)
# Uso: ./rotate_logs.sh /var/log/app.log 50M 7

set -euo pipefail
LOGFILE="${1:-/var/log/app.log}"
MAXSIZE="${2:-100M}"   # tamaño máximo antes de rotar
KEEP_DAYS="${3:-7}"

if [[ ! -f "$LOGFILE" ]]; then
  echo "Logfile $LOGFILE no existe."
  exit 1
fi

# Si el log es mayor a MAXSIZE, rotar
size_bytes=$(stat -c%s "$LOGFILE")
# Convierte MAXSIZE a bytes (solo admite K M G sufijos)
convert_to_bytes() {
  local val=${1}
  if [[ $val =~ ^([0-9]+)([KkMmGg])$ ]]; then
    num=${BASH_REMATCH[1]}
    suf=${BASH_REMATCH[2]}
    case $suf in
      [Kk]) echo $((num*1024)) ;;
      [Mm]) echo $((num*1024*1024)) ;;
      [Gg]) echo $((num*1024*1024*1024)) ;;
    esac
  else
    echo "$val"
  fi
}
max_bytes=$(convert_to_bytes "$MAXSIZE")

if (( size_bytes >= max_bytes )); then
  ts=$(date +%Y%m%d-%H%M%S)
  mv "$LOGFILE" "${LOGFILE}.$ts"
  gzip "${LOGFILE}.$ts"
  touch "$LOGFILE"
  echo "Rotated $LOGFILE -> ${LOGFILE}.$ts.gz"
else
  echo "No se requiere rotación. Tamaño actual: $size_bytes bytes"
fi

# Limpia antiguos
find "$(dirname "$LOGFILE")" -name "$(basename "$LOGFILE").*.gz" -type f -mtime +"$KEEP_DAYS" -print -delete
