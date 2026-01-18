#!/bin/sh
# Comparison operators (return 1 for true, 0 for false):

a=5
b=10
echo "Comparisons (a=$a, b=$b):"
echo "  a < b: $((a < b))"
echo "  a > b: $((a > b))"
echo "  a == b: $((a == b))"
echo "  a != b: $((a != b))"
echo "  a <= b: $((a <= b))"
echo "  a >= b: $((a >= b))"
