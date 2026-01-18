#!/bin/sh
# POSIX sh lacks range syntax for `for`, so use `while` instead:

echo "Counting to 5:"
i=1
while [ $i -le 5 ]; do
    echo "  $i"
    i=$((i + 1))
done
