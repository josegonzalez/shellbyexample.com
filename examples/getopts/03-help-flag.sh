#!/bin/sh
# Users expect `-h` to show help, but getopts doesn't handle
# it automatically. If you don't include `h` in your optstring,
# `-h` is treated as an unknown option.
#
# This example shows what happens when `-h` isn't implemented.

demo() {
    verbose=false
    OPTIND=1
    while getopts "v" opt 2>/dev/null; do
        case "$opt" in
            v) verbose=true ;;
            ?)
                echo "Unknown option"
                return 1
                ;;
        esac
    done
    echo "Running with verbose=$verbose"
}

echo "With -v (valid):"
demo -v

echo ""
echo "With -h (not in optstring):"
demo -h
