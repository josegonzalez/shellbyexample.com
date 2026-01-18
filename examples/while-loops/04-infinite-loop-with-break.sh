#!/bin/sh
# The `break` statement exits a loop early.
# The `continue` statement skips to the next iteration.

echo "Break example:"
count=0
while true; do
    count=$((count + 1))
    echo "  Iteration $count"
    if [ "$count" -ge 3 ]; then
        echo "  Breaking out"
        break
    fi
done

echo "Continue example (skip even numbers):"
i=0
while [ "$i" -lt 10 ]; do
    i=$((i + 1))
    if [ $((i % 2)) -eq 0 ]; then
        continue
    fi
    echo "  Odd: $i"
done
