#!/bin/sh
# Floating-point arithmetic requires external tools:

echo "Floating-point with bc:"
echo "  5.5 + 3.2 = $(echo "5.5 + 3.2" | bc)"
echo "  10 / 3 = $(echo "scale=2; 10 / 3" | bc)"
echo "  sqrt(2) = $(echo "scale=4; sqrt(2)" | bc)"
