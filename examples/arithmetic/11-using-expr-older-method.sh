#!/bin/sh
# Using `expr` (older method, POSIX):

echo "Using expr:"
# shellcheck disable=SC2003
echo "  5 + 3 = $(expr 5 + 3)"
# shellcheck disable=SC2003
echo "  10 - 4 = $(expr 10 - 4)"
# shellcheck disable=SC2003
echo "  6 \* 7 = $(expr 6 \* 7)" # Note: * must be escaped
# shellcheck disable=SC2003
echo "  20 / 4 = $(expr 20 / 4)"
