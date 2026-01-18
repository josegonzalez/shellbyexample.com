#!/bin/sh
# Filter with awk (more efficient for simple transforms):

echo "Using awk as filter:"
printf "10\n20\n30\n" | awk '{print $1 * 2}'
