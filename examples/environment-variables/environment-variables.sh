#!/bin/sh

: # Environment variables are key-value pairs that
: # configure how programs behave. They're inherited
: # by child processes.

: # Access environment variables with $ prefix:

echo "Current user: $USER"
echo "Home directory: $HOME"
echo "Current shell: $SHELL"
echo "Current path: $PATH"

: # Check if a variable is set:

if [ -n "$HOME" ]; then
  echo "HOME is set to: $HOME"
fi

if [ -z "$UNDEFINED_VAR" ]; then
  echo "UNDEFINED_VAR is not set"
fi

: # Set a shell variable (not exported):

MY_VAR="hello"
echo "Shell variable: $MY_VAR"

: # Export makes it available to child processes:

export MY_EXPORTED="world"

: # Check if it's exported by running a subshell:

sh -c 'echo "In child - MY_VAR: ${MY_VAR:-<unset>}"'
sh -c 'echo "In child - MY_EXPORTED: ${MY_EXPORTED:-<unset>}"'

: # Set and export in one line:

export GREETING="Hello, World!"
echo "Greeting: $GREETING"

: # Common environment variables:

echo "Common environment variables:"
echo "  USER=$USER"
echo "  HOME=$HOME"
echo "  PWD=$PWD"
echo "  PATH=$PATH"
echo "  SHELL=$SHELL"
echo "  TERM=$TERM"
echo "  LANG=$LANG"

: # Modify PATH temporarily:

echo "Original PATH has $(echo "$PATH" | tr ':' '\n' | wc -l | tr -d ' ') entries"

PATH="$HOME/bin:$PATH"
echo "After prepending \$HOME/bin: PATH starts with ${PATH%%:*}"

: # Set variable for a single command:

GREETING="Hola" sh -c 'echo "Temporary: $GREETING"'
echo "After command: GREETING=${GREETING:-<unset>}"

: # Unset a variable:

export TEMP_VAR="temporary"
echo "Before unset: $TEMP_VAR"
unset TEMP_VAR
echo "After unset: ${TEMP_VAR:-<unset>}"

: # Use `env` to view all environment variables:

echo "First 5 environment variables:"
env | head -5

: # Use `env` to run command with modified environment:

env MYVAR=test sh -c 'echo "MYVAR=$MYVAR"'

: # Clear environment and run with specific vars:

env -i PATH="$PATH" sh -c 'echo "Clean env, PATH set: ${PATH:+yes}"'

: # Default values for variables:

# ${VAR:-default} - use default if unset or empty
echo "DB_HOST: ${DB_HOST:-localhost}"

# ${VAR:=default} - use default and assign if unset
: "${CACHE_DIR:=/tmp/cache}"
echo "CACHE_DIR: $CACHE_DIR"

# ${VAR:?message} - error if unset or empty
# : "${REQUIRED_VAR:?must be set}"  # Would exit if unset

# ${VAR:+value} - use value if var is set
echo "USER is set: ${USER:+yes}"
echo "UNSET is set: ${UNSET_VAR:+yes}"

: # Export all variables automatically (not recommended):

# set -a  # or set -o allexport
# source config.env
# set +a

: # Check if command exists in PATH:

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

if command_exists git; then
  echo "git is installed"
fi

: # Configuration file pattern:

load_config() {
  # Default values
  APP_PORT="${APP_PORT:-3000}"
  APP_HOST="${APP_HOST:-0.0.0.0}"
  APP_DEBUG="${APP_DEBUG:-false}"

  echo "Config:"
  echo "  APP_PORT=$APP_PORT"
  echo "  APP_HOST=$APP_HOST"
  echo "  APP_DEBUG=$APP_DEBUG"
}

echo "Default config:"
load_config

echo "Overridden config:"
APP_PORT=8080 APP_DEBUG=true load_config

: # [bash]
: # Bash provides additional features

: # Read-only export:
# declare -rx CONST_VAR="cannot change"

: # List all exported variables:
# export -p

: # Check if variable is exported:
# if declare -p VAR 2>/dev/null | grep -q 'declare -x'; then
#     echo "VAR is exported"
# fi
: # [/bash]

: # Security: Don't put secrets in environment variables
: # that might be logged. Use files with restricted permissions.

echo "Environment variable demo complete"
