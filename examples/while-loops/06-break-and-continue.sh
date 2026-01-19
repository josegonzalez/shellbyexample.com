#!/bin/sh
# As with `for` loops, `break` exits a loop early and `continue`
# skips to the next iteration. These are especially useful with
# `while true` for loops that run until some condition inside
# the loop triggers an exit.

# Using break: exit when a condition is met
echo "Break example (exit on condition):"
count=0
while true; do
    count=$((count + 1))
    echo "  Iteration $count"
    if [ "$count" -ge 3 ]; then
        echo "  Breaking out"
        break
    fi
done

# Using continue: skip certain iterations
echo "Continue example (skip even numbers):"
i=0
while [ "$i" -lt 6 ]; do
    i=$((i + 1))
    if [ $((i % 2)) -eq 0 ]; then
        continue
    fi
    echo "  Odd: $i"
done
