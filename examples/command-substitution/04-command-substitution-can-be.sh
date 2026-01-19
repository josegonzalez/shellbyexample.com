#!/bin/sh
# Command substitution can be nested with `$()` syntax.
#
# This is useful when you need to capture the output of
# a command and use it as a value in another command.
#
# Remember to quote the nested commands to
# avoid word splitting and globbing.

echo "Shell: $(basename "$(which sh)")"
echo "Shell directory: $(dirname "$(which sh)")"
echo "Parent directory: $(dirname "$(dirname "$(which sh)")")"
