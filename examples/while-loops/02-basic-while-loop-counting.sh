#!/bin/sh
# Basic while loop counting from 1 to 5:

i=1
while [ "$i" -le 5 ]; do
  echo "Count: $i"
  i=$((i + 1))
done
