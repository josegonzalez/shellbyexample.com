#!/bin/sh
# While loops shine when you don't know in advance how many
# iterations you need. Unlike `for` loops that iterate over a
# fixed list, `while` loops continue until a condition changes.
#
# Use `while` when:
#
# - Waiting for something to happen (polling)
# - Processing input until end-of-file
# - Retrying operations until success
# - Any situation where the iteration count is unknown

# For loop: you know the items ahead of time
echo "For loop (fixed list):"
for item in a b c; do
    echo "  $item"
done

# While loop: continue until a condition is met
echo "While loop (condition-based):"
n=1
while [ "$n" -le 3 ]; do
    echo "  iteration $n"
    n=$((n + 1))
done
