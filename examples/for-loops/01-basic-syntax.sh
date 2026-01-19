#!/bin/sh
# The `for` loop iterates over a list of items, running
# the same code for each one. The basic syntax is:
#
#   for VARIABLE in LIST; do
#       commands using $VARIABLE
#   done
#
# The loop assigns each item from LIST to VARIABLE, then
# executes the commands between `do` and `done`. The keywords
# `do` and `done` mark the start and end of the loop body.

echo "Iterating over fruits:"
for fruit in apple banana cherry; do
    echo "  I like $fruit"
done
