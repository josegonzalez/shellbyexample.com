#!/bin/sh
# Users can combine multiple flags into one argument.
# Instead of `-v -d`, they can write `-vd`.
# getopts handles this automatically.
#
# This also works with options that take arguments:
# `-vn Alice` is the same as `-v -n Alice`.

demo() {
    verbose=false
    debug=false
    name=""
    OPTIND=1
    while getopts "vdn:" opt; do
        case "$opt" in
            v) verbose=true ;;
            d) debug=true ;;
            n) name="$OPTARG" ;;
        esac
    done
    echo "Verbose: $verbose, Debug: $debug, Name: ${name:-<none>}"
}

echo "Separate flags: -v -d"
demo -v -d

echo "Combined flags: -vd"
demo -vd

echo "Combined with argument: -vdn Alice"
demo -vdn "Alice"
