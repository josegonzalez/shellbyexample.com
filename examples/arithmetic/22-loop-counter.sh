#!/bin/sh
# Loop counter:

sum=0
i=1
while [ "$i" -le 10 ]; do
  sum=$((sum + i))
  i=$((i + 1))
done
echo "Sum of 1-10: $sum"
