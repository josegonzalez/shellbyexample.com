#!/bin/sh
# Practical example: Loop counter using arithmetic operations.

sum=0
i=1
while [ "$i" -le 10 ]; do
  sum=$((sum + i))
  i=$((i + 1))
done
echo "Sum of 1-10: $sum"
