#!/bin/sh
# The loop variable persists after the loop ends.

for letter in a b c; do
    :  # do nothing
done
echo "Last letter was: $letter"
