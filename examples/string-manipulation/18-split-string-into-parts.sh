#!/bin/sh
# Split string into parts:

csv="apple,banana,cherry"
echo "Splitting '$csv':"

# Using IFS
IFS=','
set -- $csv
echo "  Part 1: $1"
echo "  Part 2: $2"
echo "  Part 3: $3"
unset IFS
