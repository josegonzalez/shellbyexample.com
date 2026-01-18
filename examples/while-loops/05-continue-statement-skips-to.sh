#!/bin/sh
# The `continue` statement skips to the next iteration:

echo "Skipping even numbers:"
i=0
while [ "$i" -lt 10 ]; do
  i=$((i + 1))
  # Skip even numbers
  if [ $((i % 2)) -eq 0 ]; then
    continue
  fi
  echo "  Odd: $i"
done
