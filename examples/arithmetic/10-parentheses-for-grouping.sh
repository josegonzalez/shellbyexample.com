#!/bin/sh
# Parentheses for grouping:

echo "Order of operations:"
echo "  2 + 3 * 4 = $((2 + 3 * 4))"
echo "  (2 + 3) * 4 = $(((2 + 3) * 4))"
