#!/bin/sh
# The `seq` command generates sequences of numbers for
# iteration. While not POSIX-standard, `seq` is widely
# available on Linux and macOS systems.
#
# Syntax forms:
#
# - `seq END`: Count from 1 to END
# - `seq START END`: Count from START to END
# - `seq START STEP END`: Count from START to END by STEP
#
# The output of `seq` is used with command substitution
# to generate the list of items for the loop.

echo "Count 1 to 5:"
for n in $(seq 5); do
    echo "  $n"
done

echo ""
echo "Count 3 to 7:"
for n in $(seq 3 7); do
    echo "  $n"
done

echo ""
echo "Count by 2s (1 to 9):"
for n in $(seq 1 2 9); do
    echo "  $n"
done
