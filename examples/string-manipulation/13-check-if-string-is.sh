#!/bin/sh
# Check if string is empty or not:

empty=""
nonempty="hello"

[ -z "$empty" ] && echo "empty is zero-length"
[ -n "$nonempty" ] && echo "nonempty has content"
