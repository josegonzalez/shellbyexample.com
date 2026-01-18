#!/bin/sh
# For security, don't put secrets in environment variables
# that might be logged. Use files with restricted permissions.

# Bad: Environment variables can leak via logs, errors, or /proc
# shellcheck disable=SC2034
API_KEY="secret123"
echo "Env vars visible to child processes and logs"

# Better: Use a file with restricted permissions
echo "my_secret_token" >/tmp/secret.txt
chmod 600 /tmp/secret.txt

# Read secret from file when needed
SECRET=$(cat /tmp/secret.txt)
# shellcheck disable=SC2012
echo "Secret file permissions: $(ls -l /tmp/secret.txt | cut -d' ' -f1)"

# Clean up
rm /tmp/secret.txt
