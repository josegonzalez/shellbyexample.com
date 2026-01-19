#!/bin/sh
# You can mix flags and options with arguments. Each `:` only
# applies to the letter immediately before it.
#
# `"vn:o:"` means:
# - `-v` is a flag (no argument)
# - `-n` takes an argument
# - `-o` takes an argument

demo() {
    verbose=false
    name=""
    output=""
    OPTIND=1
    while getopts "vn:o:" opt; do
        case "$opt" in
            v) verbose=true ;;
            n) name="$OPTARG" ;;
            o) output="$OPTARG" ;;
        esac
    done
    echo "Verbose: $verbose, Name: ${name:-<none>}, Output: ${output:-<none>}"
}

echo "With -v -n Alice -o results.txt:"
demo -v -n "Alice" -o "results.txt"

echo "With -n Bob only:"
demo -n "Bob"
