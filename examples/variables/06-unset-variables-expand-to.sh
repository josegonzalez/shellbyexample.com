#!/bin/sh
# Unset variables expand to empty strings by default.
# You can use `unset` to remove an existing variable,
# returning it to the undefined state.

# shellcheck disable=SC2154
echo "Unset variable: '$undefined_var'"

temp="temporary"
echo "Before unset: $temp"
unset temp
echo "After unset: '$temp'"
