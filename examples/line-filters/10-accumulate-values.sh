#!/bin/sh
# Accumulate values using a subshell:

total=0
printf "10\n20\n30\n" | (
  while read -r n; do
    total=$((total + n))
  done
  echo "Total: $total"
)
