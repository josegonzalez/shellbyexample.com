#!/bin/sh
# Functions return exit status with `return`.
# Return 0 for success, non-zero for failure.

is_even() {
    if [ $(($1 % 2)) -eq 0 ]; then
        return 0 # success/true
    else
        return 1 # failure/false
    fi
}

if is_even 4; then
    echo "4 is even"
fi

if ! is_even 7; then
    echo "7 is odd"
fi
