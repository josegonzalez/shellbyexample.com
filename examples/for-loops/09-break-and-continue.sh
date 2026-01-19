#!/bin/sh
# The `break` and `continue` statements control loop flow:
#
# - `break` exits the loop immediately, skipping remaining
#   iterations and continuing after `done`
# - `continue` skips the rest of the current iteration and
#   moves to the next item
#
# These are useful for stopping early when you find what
# you need (break) or skipping items that don't apply (continue).

echo "Using 'break' to exit early:"
for n in 1 2 3 4 5; do
    if [ "$n" -eq 3 ]; then
        echo "  found 3, stopping"
        break
    fi
    echo "  checking $n"
done

echo ""
echo "Using 'continue' to skip items:"
for n in 1 2 3 4 5; do
    if [ "$n" -eq 3 ]; then
        echo "  skipping 3"
        continue
    fi
    echo "  processing $n"
done
