#!/bin/sh
# To remove a variable from the environment, use `unset`.
# To see what's currently exported, use `env`. To run a
# command with a completely clean environment, use `env -i`.
#
# These tools are useful for testing, debugging, and
# isolating programs from the surrounding environment.

# unset removes a variable entirely
export TEMP_VAR="temporary"
echo "Before unset: TEMP_VAR=$TEMP_VAR"
unset TEMP_VAR
echo "After unset:  TEMP_VAR=${TEMP_VAR:-<removed>}"

# env with no arguments lists all exported variables
echo ""
echo "Exported variables (first 5):"
env | sort | head -5

# env -i runs a command with an empty environment
# Here we pass only PATH so the child can find commands
echo ""
echo "Clean environment with env -i:"
# shellcheck disable=SC2016
env -i PATH="$PATH" sh -c '
    count=$(env | wc -l | tr -d " ")
    echo "  Variables in clean env: $count"
    echo "  PATH is set: ${PATH:+yes}"
    echo "  USER is set: ${USER:-<not set>}"
'
