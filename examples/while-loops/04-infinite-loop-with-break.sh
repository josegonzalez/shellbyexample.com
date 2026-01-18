#!/bin/sh
# Infinite loop with break:

count=0
while true; do
  count=$((count + 1))
  echo "Iteration $count"
  if [ "$count" -ge 3 ]; then
    echo "Breaking out"
    break
  fi
done
