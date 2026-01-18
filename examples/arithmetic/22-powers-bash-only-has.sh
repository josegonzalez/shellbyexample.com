#!/bin/sh
# Practical example: Powers
#
# Only bash has `**` operator, use `bc` for POSIX compatibility.

base=2
exp=10
power=$(echo "$base ^ $exp" | bc)
echo "Power: $base^$exp = $power"

echo "Arithmetic examples complete"
