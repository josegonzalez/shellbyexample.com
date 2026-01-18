#!/bin/sh
# The `while` loop executes commands as long as
# a condition is true. It's essential for condition-based iteration.
# This example shows a basic while loop counting from 1 to 5.

i=1
while [ "$i" -le 5 ]; do
  echo "Count: $i"
  i=$((i + 1))
done
