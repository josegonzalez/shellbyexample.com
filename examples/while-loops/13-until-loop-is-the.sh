#!/bin/sh
# The `until` loop is the opposite of while -
# it runs until the condition becomes true:

echo "Until loop:"
num=1
until [ "$num" -gt 3 ]; do
  echo "  num is $num"
  num=$((num + 1))
done
