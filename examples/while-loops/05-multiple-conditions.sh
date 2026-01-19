#!/bin/sh
# You can combine multiple conditions using `&&` (AND) and
# `||` (OR) operators. The loop continues while the combined
# condition is true.
#
# - `&&`: ALL conditions must be true to continue
# - `||`: ANY condition being true continues the loop

# AND: both conditions must be true
echo "Using && (both must be true):"
x=0
y=10
while [ "$x" -lt 3 ] && [ "$y" -gt 7 ]; do
    echo "  x=$x, y=$y"
    x=$((x + 1))
    y=$((y - 1))
done

# OR: loop continues if either condition is true
echo "Using || (either can be true):"
a=0
b=0
while [ "$a" -lt 2 ] || [ "$b" -lt 3 ]; do
    echo "  a=$a, b=$b"
    a=$((a + 1))
    b=$((b + 1))
done
