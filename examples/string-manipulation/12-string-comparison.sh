#!/bin/sh
# String comparison:

s1="apple"
s2="banana"

if [ "$s1" = "$s2" ]; then
  echo "$s1 equals $s2"
else
  echo "$s1 does not equal $s2"
fi

# Lexicographic comparison
if [ "$s1" \< "$s2" ]; then
  echo "$s1 comes before $s2"
fi
