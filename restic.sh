#!/bin/sh

set -e

export $(cat /app/.env | xargs)

echo "=== Backup started: $(date) ==="
restic cat config >/dev/null 2>&1 || { [ $? -eq 10 ] && restic init; }
restic backup /app/backup --verbose
restic forget --keep-daily 7 --keep-weekly 4 --keep-monthly 12 --keep-yearly 100 --prune --verbose
echo "=== Backup finished: $(date) ==="
