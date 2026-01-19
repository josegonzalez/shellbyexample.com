#!/bin/sh
# Command substitution can be also be used in conditional checks.
# This should be used sparingly as it can make the code harder to read
# when nested deeply or if the command is complex.
#
# For more complex conditional checks, it's better to capture the output
# of the command in a variable and use that in the conditional check.

if [ "$(uname -s)" = "Linux" ]; then
    echo "Running on Linux"
elif [ "$(uname -s)" = "Darwin" ]; then
    echo "Running on macOS"
else
    echo "Running on unknown kernel"
fi
