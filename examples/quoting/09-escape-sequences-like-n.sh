#!/bin/sh
# Escape sequences like `\n` and `\t` are NOT interpreted in double quotes:

echo "Line 1\nLine 2"  # Note: \n is NOT interpreted here (use echo -e or $'...')
echo "Tab:\tseparated" # Note: \t is NOT interpreted here (use echo -e or $'...')
