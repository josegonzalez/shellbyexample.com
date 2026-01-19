#!/bin/sh
# `getopts` is a shell built-in for parsing command-line
# options. It supports short options like `-v` and `-n value`.
#
# Limitations: getopts only handles short options. It does not
# support `--long` options or the `-f=value` syntax. For those,
# you'll need external tools like GNU `getopt` or manual parsing.
#
# The basic pattern is a `while` loop with a `case` statement.
# The optstring `"v"` tells getopts to accept the `-v` flag.
# The variable `opt` receives the option letter being processed.

demo() {
    verbose=false
    OPTIND=1
    while getopts "v" opt; do
        case "$opt" in
            v) verbose=true ;;
        esac
    done
    echo "Verbose: $verbose"
}

echo "With -v:"
demo -v

echo "Without flags:"
demo
