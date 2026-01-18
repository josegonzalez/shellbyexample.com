#!/bin/sh
# Variables in arithmetic (no $ needed inside):

x=10
y=3
echo "With variables (x=$x, y=$y):"
echo "  x + y = $((x + y))"
echo "  x * y = $((x * y))"
echo "  x / y = $((x / y))" # Integer division
echo "  x % y = $((x % y))"
