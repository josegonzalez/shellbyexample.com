#!/bin/sh
# Export all variables automatically (not recommended).
# `set -a` exports all variables defined after it.

# Create a config file to source
cat >/tmp/config.env <<'EOF'
DB_HOST=localhost
DB_PORT=5432
APP_NAME=myapp
EOF

# Without set -a, sourced variables are not exported
# shellcheck disable=SC1091
. /tmp/config.env
sh -c 'echo "Without -a: DB_HOST=${DB_HOST:-<not set>}"'

# With set -a, all variables are automatically exported
set -a
# shellcheck disable=SC1091
. /tmp/config.env
set +a

sh -c 'echo "With -a: DB_HOST=$DB_HOST"'

rm /tmp/config.env
