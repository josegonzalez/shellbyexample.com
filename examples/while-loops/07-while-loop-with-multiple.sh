#!/bin/sh
# While loop with multiple conditions:

x=0
y=10
while [ "$x" -lt 5 ] && [ "$y" -gt 5 ]; do
    echo "x=$x, y=$y"
    x=$((x + 1))
    y=$((y - 1))
done
