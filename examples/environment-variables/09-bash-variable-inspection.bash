#!/bin/bash
# Bash provides built-in commands for inspecting and
# controlling variable attributes that aren't available
# in POSIX sh.
#
# - `declare -rx VAR=value` creates a read-only export
# - `export -p` lists all exported variables
# - `declare -p VAR` shows a variable's attributes
#
# These are useful for debugging and for protecting
# critical variables from accidental modification.

# declare -rx creates a variable that is both exported
# and read-only — it cannot be changed or unset
declare -rx APP_VERSION="1.0.0"
echo "Read-only export:"
echo "  APP_VERSION=$APP_VERSION"

# Attempting to change it would produce an error:
#   APP_VERSION="2.0.0"  # bash: APP_VERSION: readonly variable

# export -p lists all exported variables with their values
echo ""
echo "All exported variables (first 5):"
export -p | head -5

# declare -p shows a specific variable's attributes
# The flags tell you how the variable was declared:
#   -x means exported, -r means read-only
echo ""
echo "Inspecting APP_VERSION:"
declare -p APP_VERSION

echo ""
echo "Inspecting HOME:"
declare -p HOME
