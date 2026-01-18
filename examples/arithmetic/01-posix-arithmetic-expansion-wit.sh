#!/bin/sh
# Shell scripting supports arithmetic operations
# through several mechanisms. This example covers
# the main ways to do math in shell scripts.
#
# POSIX arithmetic expansion with `$(( ))`:

echo "Basic arithmetic with \$(( )):"
echo "  5 + 3 = $((5 + 3))"
echo "  10 - 4 = $((10 - 4))"
echo "  6 * 7 = $((6 * 7))"
echo "  20 / 4 = $((20 / 4))"
echo "  17 % 5 = $((17 % 5))" # Modulo (remainder)
