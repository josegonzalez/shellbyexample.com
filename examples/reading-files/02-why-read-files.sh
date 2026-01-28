#!/bin/sh
# Scripts become much more useful when they read data
# from files instead of hardcoding values. This lets
# you change behavior without editing the script itself.
#
# A common pattern is reading configuration from a
# `key=value` file — the same format used by `.env`
# files, systemd units, and many Unix tools.

# Create a config file
cat >/tmp/app.conf <<'EOF'
APP_NAME=My Application
APP_PORT=8080
APP_DEBUG=false
EOF

# Bad: hardcoded values buried in the script
echo "=== Hardcoded (fragile) ==="
echo "Starting My Application on port 8080..."

# Good: read values from the config file
echo ""
echo "=== From config file (flexible) ==="
while IFS='=' read -r key value; do
    case "$key" in
        APP_NAME)  app_name="$value" ;;
        APP_PORT)  app_port="$value" ;;
        APP_DEBUG) app_debug="$value" ;;
    esac
done </tmp/app.conf

echo "Starting $app_name on port $app_port (debug=$app_debug)..."
