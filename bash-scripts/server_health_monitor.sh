#!/bin/bash
# server_health_monitor.sh
# Monitors CPU, RAM, and disk usage and sends email alerts

CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
MEM=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
DISK=$(df / | grep / | awk '{print $5}' | sed 's/%//g')

if (( ${CPU%.*} > 80 )); then
    echo "High CPU usage: $CPU%" | mail -s "Server Alert" admin@example.com
fi

if (( ${MEM%.*} > 80 )); then
    echo "High Memory usage: $MEM%" | mail -s "Server Alert" admin@example.com
fi

if (( ${DISK%.*} > 80 )); then
    echo "Low Disk Space: $DISK%" | mail -s "Server Alert" admin@example.com
fi
