#!/bin/sh
# Scripts should validate that they received the expected
# arguments. Use `$#` to check the argument count:
#
# - `$# -eq 0` means no arguments were provided
# - `$# -ne N` means the count doesn't equal N (exactly N expected)
# - `$# -lt N` means fewer than N arguments (at least N expected)

check_any_args() {
    if [ $# -eq 0 ]; then
        echo "Error: No arguments provided"
        echo "Usage: command <arg>..."
        return 1
    fi
    echo "Got $# argument(s): $*"
}

check_exactly_two() {
    if [ $# -ne 2 ]; then
        echo "Error: Expected exactly 2 arguments, got $#"
        echo "Usage: command <source> <destination>"
        return 1
    fi
    echo "Got exactly two: $1 and $2"
}

echo "Testing check_any_args:"
check_any_args
check_any_args one two

echo ""
echo "Testing check_exactly_two:"
check_exactly_two one
check_exactly_two one two
