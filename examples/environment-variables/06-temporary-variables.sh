#!/bin/sh
# Sometimes you need a variable only for a single command
# or the current session, without permanently changing
# the environment.
#
# Three approaches:
#
# 1. `VAR=value command` — sets `VAR` only for that command
# 2. `env VAR=value command` — same, using the env utility
# 3. Modifying `PATH` in the current shell session

# Inline assignment: VAR exists only for the command
echo "Inline assignment (VAR=value command):"
GREETING="Hola" sh -c 'echo "  During: GREETING=$GREETING"'
echo "  After:  GREETING=${GREETING:-<gone>}"

# The env utility does the same thing
echo ""
echo "Using env:"
# shellcheck disable=SC2016
env COLOR="blue" sh -c 'echo "  During: COLOR=$COLOR"'
echo "  After:  COLOR=${COLOR:-<gone>}"

# Modifying PATH for the current session
echo ""
echo "Modifying PATH temporarily:"
echo "  PATH has $(echo "$PATH" | tr ':' '\n' | wc -l | tr -d ' ') entries"
PATH="$HOME/bin:$PATH"
echo "  After prepend, PATH starts with: ${PATH%%:*}"
