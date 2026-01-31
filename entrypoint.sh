#!/bin/sh

env | grep -E '^(AWS_|RESTIC_)' > /app/.env
chmod 600 /app/.env
exec crond -f
