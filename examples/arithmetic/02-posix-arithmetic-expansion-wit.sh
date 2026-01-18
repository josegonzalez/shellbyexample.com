#!/bin/sh
# POSIX arithmetic expansion with $(( )):

echo "Basic arithmetic with \$(( )):"
echo "  5 + 3 = $((5 + 3))"
echo "  10 - 4 = $((10 - 4))"
echo "  6 * 7 = $((6 * 7))"
echo "  20 / 4 = $((20 / 4))"
echo "  17 % 5 = $((17 % 5))" # Modulo (remainder)
