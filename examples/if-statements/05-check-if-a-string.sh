#!/bin/sh
# All `test` expressions are supported, including checking if a string is empty or non-empty.

empty=""
nonempty="hello"

if [ -z "$empty" ]; then
    echo "Variable is empty"
fi

if [ -n "$nonempty" ]; then
    echo "Variable is not empty"
fi
