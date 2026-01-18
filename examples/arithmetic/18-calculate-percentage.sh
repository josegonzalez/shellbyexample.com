#!/bin/sh
# Practical example: Calculate percentage using arithmetic operations.

total=250
part=75
percent=$((part * 100 / total))
echo "Percentage: $part of $total = $percent%"
