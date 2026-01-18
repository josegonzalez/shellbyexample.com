#!/bin/sh
# String comparisons use `=` and `!=`.

name="Alice"

if [ "$name" = "Alice" ]; then
    echo "Hello, Alice!"
fi

if [ "$name" != "Bob" ]; then
    echo "Hello, not Bob!"
fi
