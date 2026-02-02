#!/bin/sh

# Validate required environment variables
: "${AWS_ACCESS_KEY_ID:?Environment variable AWS_ACCESS_KEY_ID is required}"
: "${AWS_SECRET_ACCESS_KEY:?Environment variable AWS_SECRET_ACCESS_KEY is required}"
: "${RESTIC_REPOSITORY:?Environment variable RESTIC_REPOSITORY is required}"
: "${RESTIC_PASSWORD:?Environment variable RESTIC_PASSWORD is required}"

# Export relevant environment variables to .env file
env | grep -E '^(AWS_|RESTIC_)' > /app/.env
chmod 600 /app/.env
exec crond -f
