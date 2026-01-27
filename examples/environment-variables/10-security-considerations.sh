#!/bin/sh
# Environment variables are convenient for configuration,
# but they are a poor choice for storing secrets like API
# keys, passwords, and tokens.
#
# Why? Because environment variables are:
#
# - Inherited by every child process
# - Visible in `/proc/PID/environ` on Linux
# - Often captured in error logs and debug output
# - Exposed by commands like `env` and `printenv`
#
# A safer alternative is storing secrets in files with
# restricted permissions, and reading them when needed.

# Demonstrating the risk: child processes see everything
export API_KEY="secret123"
echo "Child process can see the secret:"
sh -c 'echo "  API_KEY=$API_KEY"'
unset API_KEY

# Better approach: use a file with restricted permissions
echo ""
echo "Storing a secret in a file instead:"
echo "my_secret_token" >/tmp/secret.txt
chmod 600 /tmp/secret.txt

# Only the file owner can read it
echo "  Permissions: $(ls -l /tmp/secret.txt | cut -d' ' -f1)"

# Read the secret only when needed
SECRET=$(cat /tmp/secret.txt)
echo "  Secret read from file: ${SECRET}"

rm /tmp/secret.txt
echo "  Cleaned up secret file"
