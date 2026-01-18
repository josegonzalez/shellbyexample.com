#!/bin/sh
# Using `expr` (older method, POSIX):

echo "Using expr:"
echo "  5 + 3 = $(expr 5 + 3)"
echo "  10 - 4 = $(expr 10 - 4)"
echo "  6 \* 7 = $(expr 6 \* 7)" # Note: * must be escaped
echo "  20 / 4 = $(expr 20 / 4)"
