#!/bin/sh
# `$@` contains all arguments, `$#` is the count.

show_args() {
    echo "Number of arguments: $#"
    for arg in "$@"; do
        echo "  - $arg"
    done
}

show_args one two three
