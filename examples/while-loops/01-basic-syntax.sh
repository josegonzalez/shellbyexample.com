#!/bin/sh
# The `while` loop executes commands as long as a condition
# is true.
#
# The condition is tested BEFORE each iteration. If false
# initially, the loop body never runs at all.

i=1
while [ "$i" -le 5 ]; do
    echo "Count: $i"
    i=$((i + 1))
done
