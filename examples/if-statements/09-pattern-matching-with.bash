#!/bin/bash
# Bash supports pattern matching with `[[ ]]` expressions.
# These are similar to regular expressions, but used for more
# simple string matching.

filename="example.txt"
if [[ $filename = *.txt ]]; then
    echo "It's a text file"
fi
