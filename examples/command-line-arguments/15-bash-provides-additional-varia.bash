#!/bin/bash
# Bash provides additional variables:
#
# - `${@:n:m}` - Slice of arguments starting at n, m elements
# - `${*:n:m}` - Slice of arguments starting at n, m elements
# - `${!#}`    - The last argument
#
# Note: The difference between `${@:n:m}` and `${*:n:m}` is that `${@:n:m}` is an array and `${*:n:m}` is a string.

call_with_args() {
    echo "Last argument: ${!#}"
    echo "Args 2-3: ${*:2:2}"
    # shellcheck disable=SC2145
    echo "Args 2-3: ${@:2:2}"
}

call_with_args a b c d
