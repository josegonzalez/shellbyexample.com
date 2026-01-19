#!/bin/sh
# When you need all arguments at once, use `$@` or `$*`:
#
# - `$@` expands to all arguments as separate words
# - `$*` expands to all arguments as a single string
#
# Use `$@` when you want to iterate over arguments or pass
# them to another command. Use `$*` when you need a single
# string representation (rare in practice).

show_difference() {
    echo "With \$@ (separate words in a for loop):"
    for arg in "$@"; do
        echo "  - $arg"
    done

    echo ""
    echo "With \$* (single string):"
    echo "  $*"
}

show_difference apple banana cherry
