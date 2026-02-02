#!/bin/sh

# Prevent concurrent executions
LOCKFILE="/app/restic.lock"
exec 9>"$LOCKFILE"
if ! flock -n 9; then
  echo "=== Backup skipped (already running): $(date) ==="
  exit 0
fi

# Exit on error and unset variables
set -eu

# Load environment variables
set -a
. /app/.env
set +a

# Perform backup and prune
echo "=== Backup started: $(date) ==="
restic cat config >/dev/null 2>&1 || { [ $? -eq 10 ] && restic init; }
restic backup /app/backup -v 
restic forget -d 7 -w 4 -m 12 -y 100 --prune -v
echo "=== Backup finished: $(date) ==="
