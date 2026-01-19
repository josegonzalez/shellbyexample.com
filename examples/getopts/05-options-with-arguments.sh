#!/bin/sh
# Some options need to accept a value, like `-n Alice`.
# A colon `:` after a letter means that option requires
# an argument.
#
# `"n:"` means `-n` takes a value. The value is stored in
# the special variable `$OPTARG`.

demo() {
    name=""
    OPTIND=1
    while getopts "n:" opt; do
        case "$opt" in
            n) name="$OPTARG" ;;
        esac
    done
    echo "Name: ${name:-<not set>}"
}

echo "With -n Alice:"
demo -n "Alice"

echo "With -n Bob:"
demo -n "Bob"
