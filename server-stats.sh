#!/bin/bash

echo "================= Server Performance Stats ================="
echo "Date: $(date)"
echo "Hostname: $(hostname)"
echo "============================================================"

echo ""
echo ">> Total CPU Usage:"
mpstat 1 1 | awk '/Average/ && $12 ~ /[0-9.]+/ {print 100 - $12 "%"}'

echo ""
echo ">> Total Memory Usage:"
free -h | awk 'NR==2{printf "Used: %s / Total: %s (%.2f%%)\n", $3,$2,$3*100/$2 }'

echo ""
echo ">> Total Disk Usage:"
df -h --total | awk '/total/ {printf "Used: %s / Total: %s (%s used)\n",$3,$2,$5}'

echo ""
echo ">> Top 5 Processes by CPU Usage:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6

echo ""
echo ">> Top 5 Processes by Memory Usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6

echo "============================================================"
echo "End of Report"
