#!/bin/sh

set -e

export $(cat /app/.env | xargs)

echo "=== Backup started: $(date) ==="
restic cat config >/dev/null 2>&1 || { [ $? -eq 10 ] && restic init; }
restic backup /app/backup -v 
restic forget -d 7 -w 4 -m 12 -y 100 --prune -v
echo "=== Backup finished: $(date) ==="
