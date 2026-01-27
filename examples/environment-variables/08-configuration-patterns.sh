#!/bin/sh
# A common pattern in real applications is loading
# configuration from a `.env` file. The shell's `source`
# command (or `.`) reads a file and executes it in the
# current shell, which sets the variables it contains.
#
# By default, sourced variables are shell-only. To make
# them environment variables (visible to child processes),
# use `set -a` before sourcing. This tells the shell to
# automatically export every variable that gets assigned.

# Create a sample config file
cat > /tmp/app.env <<'EOF'
APP_HOST=0.0.0.0
APP_PORT=3000
APP_DEBUG=false
EOF

# Source without set -a: variables are shell-only
# shellcheck disable=SC1091
. /tmp/app.env
echo "Without set -a:"
echo "  Parent sees APP_HOST: $APP_HOST"
sh -c 'echo "  Child sees APP_HOST:  ${APP_HOST:-<not visible>}"'

# Source with set -a: variables are auto-exported
set -a
# shellcheck disable=SC1091
. /tmp/app.env
set +a

echo ""
echo "With set -a:"
echo "  Parent sees APP_HOST: $APP_HOST"
sh -c 'echo "  Child sees APP_HOST:  $APP_HOST"'

# A config function with overridable defaults
echo ""
echo "Config function with defaults:"
show_config() {
    echo "  APP_PORT=${APP_PORT:-3000}"
    echo "  APP_HOST=${APP_HOST:-0.0.0.0}"
    echo "  APP_DEBUG=${APP_DEBUG:-false}"
}

show_config
echo ""
echo "Overridden via inline variables:"
APP_PORT=8080 APP_DEBUG=true show_config

rm /tmp/app.env
