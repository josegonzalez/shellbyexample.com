#!/bin/sh
# Use `unset` to remove a variable.

temp="temporary"
echo "Before unset: $temp"
unset temp
echo "After unset: $temp"
