#!/bin/sh
# When a user passes an unknown option (like `-x` when only
# `-v` is valid), getopts returns `?`. By default, getopts
# also prints an error message to stderr.
#
# It's good practice to handle the `?` case and show usage.

demo() {
    verbose=false
    OPTIND=1
    while getopts "vn:" opt; do
        case "$opt" in
            v) verbose=true ;;
            n) name="$OPTARG" ;;
            ?)
                echo "Usage: script [-v] [-n name]"
                return 1
                ;;
        esac
    done
    echo "Verbose: $verbose"
}

echo "With valid -v:"
demo -v

echo "With invalid -x (stderr suppressed for demo):"
demo -x 2>/dev/null
