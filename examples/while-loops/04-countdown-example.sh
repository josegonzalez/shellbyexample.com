#!/bin/sh
# Countdown example:

echo "Countdown:"
n=5
while [ "$n" -gt 0 ]; do
  echo "  $n"
  n=$((n - 1))
done
echo "  Liftoff!"
