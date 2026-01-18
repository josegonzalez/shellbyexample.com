#!/bin/sh
# Using `awk` for floating-point:

echo "Floating-point with awk:"
echo "  5.5 * 3.2 = $(awk 'BEGIN {print 5.5 * 3.2}')"
echo "  22 / 7 = $(awk 'BEGIN {printf "%.4f", 22/7}')"
