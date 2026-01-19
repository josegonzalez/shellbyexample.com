#!/bin/sh
# You can accept multiple flags by adding more letters to
# the optstring. Each letter becomes a valid option.
#
# Here `"vdh"` means the script accepts `-v`, `-d`, and `-h`.

demo() {
    verbose=false
    debug=false
    OPTIND=1
    while getopts "vdh" opt; do
        case "$opt" in
            v) verbose=true ;;
            d) debug=true ;;
            h) echo "Usage: script [-v] [-d] [-h]" ;;
        esac
    done
    echo "Verbose: $verbose, Debug: $debug"
}

echo "With -v -d:"
demo -v -d

echo "With -v only:"
demo -v
