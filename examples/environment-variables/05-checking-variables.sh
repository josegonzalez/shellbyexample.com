#!/bin/sh
# Scripts often need to check whether a variable is set
# and provide fallback values. The shell offers two
# approaches: test flags and parameter expansion.
#
# Test flags:
#
# - `[ -n "$VAR" ]` is true if VAR is non-empty
# - `[ -z "$VAR" ]` is true if VAR is empty or unset
#
# Parameter expansion provides four forms:
#
# - `${VAR:-default}` Use default if VAR is unset/empty
# - `${VAR:=default}` Use default AND assign it to VAR
# - `${VAR:?message}` Exit with error if VAR is unset/empty
# - `${VAR:+alternate}` Use alternate only if VAR IS set

# Test flags for conditional logic
echo "Checking with test flags:"
if [ -n "$HOME" ]; then
    echo "  HOME is set to: $HOME"
fi
if [ -z "$UNDEFINED_VAR" ]; then
    echo "  UNDEFINED_VAR is not set"
fi

# ${VAR:-default} — provide a fallback without changing VAR
echo ""
echo "Fallback values with \${VAR:-default}:"
echo "  DB_HOST: ${DB_HOST:-localhost}"
echo "  DB_PORT: ${DB_PORT:-5432}"

# ${VAR:=default} — provide a fallback AND assign it
echo ""
echo "Assign defaults with \${VAR:=default}:"
: "${CACHE_DIR:=/tmp/cache}"
echo "  CACHE_DIR is now: $CACHE_DIR"

# ${VAR:+alternate} — use a value only if VAR is set
echo ""
echo "Alternate values with \${VAR:+alternate}:"
echo "  USER is set: ${USER:+yes}"
echo "  MISSING is set: ${MISSING_VAR:+yes}"

# ${VAR:?message} — require a variable or exit
# Uncommenting the line below would exit the script
# if REQUIRED_CONFIG is not set:
#   : "${REQUIRED_CONFIG:?must be set in environment}"
echo ""
echo "\${VAR:?message} exits if VAR is unset (commented out above)"
