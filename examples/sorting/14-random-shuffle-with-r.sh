#!/bin/sh
# Random shuffle with -R (or shuf command):

echo "Random order:"
printf "1\n2\n3\n4\n5\n" | sort -R 2>/dev/null || shuf
