#!/bin/sh
# Counting is a common use of `while` loops, especially in POSIX
# sh which lacks the `{1..5}` range syntax. You can count in
# either direction by adjusting the condition and increment.

# Counting up: start low, increment, stop when limit exceeded
echo "Counting up:"
i=1
while [ "$i" -le 3 ]; do
    echo "  $i"
    i=$((i + 1))
done

# Counting down: start high, decrement, stop when limit reached
echo "Counting down:"
n=3
while [ "$n" -gt 0 ]; do
    echo "  $n"
    n=$((n - 1))
done
echo "  Liftoff!"
