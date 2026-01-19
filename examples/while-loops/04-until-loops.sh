#!/bin/sh
# The `until` loop is the opposite of `while` - it runs until
# the condition becomes true. Use `until` when thinking about
# the stopping condition is more natural than the continuation
# condition.
#
# These two forms are equivalent:
#
# - `while [ ! CONDITION ]; do ...`: continue while NOT true
# - `until [ CONDITION ]; do ...`: continue until true

# With while: "keep going while num is NOT greater than 3"
echo "Using while (with negated condition):"
num=1
while [ "$num" -le 3 ]; do
    echo "  num is $num"
    num=$((num + 1))
done

# With until: "keep going until num is greater than 3"
echo "Using until (same result):"
num=1
until [ "$num" -gt 3 ]; do
    echo "  num is $num"
    num=$((num + 1))
done
