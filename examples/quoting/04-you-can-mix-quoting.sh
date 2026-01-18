#!/bin/sh
# You can mix quoting styles in the same string.
# If the outer quotes are double quotes, the inner quotes can be single quotes without escaping.
# If the outer quotes are single quotes, the inner quotes can be double quotes without escaping.
#
# In this example, we use double quotes for the outer quotes and single quotes for the inner quotes.

name="World"
echo "It's a $name"
echo 'Say "Hello"'
