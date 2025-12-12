#!/usr/bin/env bash
# monitor_network.sh
# Mide uso de ancho de banda por interfaz usando /proc/net/dev y muestra conexiones establecidas
# Uso: ./monitor_network.sh

set -euo pipefail
echo "=== Interfaces (estado) ==="
ip -brief addr

echo ""
echo "=== Estadísticas /proc/net/dev (RX/TX en bytes) ==="
awk 'NR>2 {print $1,$2,$10}' /proc/net/dev

echo ""
echo "=== Conexiones establecidas y puertos escuchando ==="
ss -tunapl | head -n 30
