#!/bin/sh
# Arguments beyond $9 need braces:

set -- a b c d e f g h i j k l

echo "Arg 1: $1"
echo "Arg 9: $9"
echo "Arg 10: ${10}"
echo "Arg 12: ${12}"
