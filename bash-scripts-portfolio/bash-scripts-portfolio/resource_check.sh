#!/usr/bin/env bash
# resource_check.sh
# Muestra métricas básicas de CPU, memoria y disco
# Uso: ./resource_check.sh

set -euo pipefail
echo "=== Uso de CPU ==="
top -bn1 | head -n5

echo ""
echo "=== Uso de memoria ==="
free -h

echo ""
echo "=== Uso de disco ==="
df -hT --total | sed -n '1,8p'

echo ""
echo "=== Procesos con más CPU y memoria ==="
ps aux --sort=-%cpu | awk 'NR<=10{print NR-1, $3"% CPU", $4"% MEM", $11}' 
ps aux --sort=-%mem | awk 'NR<=10{print NR-1, $3"% CPU", $4"% MEM", $11}'
