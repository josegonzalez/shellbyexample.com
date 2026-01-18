#!/bin/sh
# - `$@` expands to all arguments as separate words.
# - `$*` expands to all arguments as a single word when quoted.

cmd_with_args() {
    echo "All arguments (\$@):"
    for arg in "$@"; do
        echo "  - $arg"
    done

    echo "All arguments (\$*):"
    echo "  $*"
}

cmd_with_args a b c d e
