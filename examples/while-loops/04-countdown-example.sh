#!/bin/sh
# The condition is tested before each iteration.
# If false initially, the loop body never runs.
#
# A countdown example:

echo "Countdown:"
n=5
while [ "$n" -gt 0 ]; do
  echo "  $n"
  n=$((n - 1))
done
echo "  Liftoff!"
