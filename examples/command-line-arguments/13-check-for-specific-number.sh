#!/bin/sh
# Check for specific number of arguments with `-ne`:

exactly_two() {
    if [ $# -ne 2 ]; then
        echo "Usage: exactly_two <arg1> <arg2>"
        return 1
    fi
    echo "Got exactly two: $1 and $2"
}

exactly_two one two
exactly_two one || echo "Failed to get exactly two arguments"
