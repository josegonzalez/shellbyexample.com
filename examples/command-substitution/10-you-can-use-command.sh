#!/bin/sh
# You can use command substitution in arithmetic.

# shellcheck disable=SC2012
files=$(ls | wc -l)
echo "Double the files: $((files * 2))"
