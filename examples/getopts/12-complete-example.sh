#!/bin/sh
# Here's a complete example combining all getopts concepts:
# flags, options with arguments, silent error handling,
# and positional arguments.
#
# This pattern is commonly used in production shell scripts.

process_files() {
    verbose=false
    output=""
    OPTIND=1

    while getopts ":vo:h" opt; do
        case "$opt" in
            v) verbose=true ;;
            o) output="$OPTARG" ;;
            h)
                echo "Usage: process [-v] [-o outfile] file..."
                return 0
                ;;
            :)
                echo "Error: -$OPTARG requires an argument" >&2
                return 1
                ;;
            ?)
                echo "Error: Unknown option -$OPTARG" >&2
                return 1
                ;;
        esac
    done
    shift $((OPTIND - 1))

    [ $# -eq 0 ] && {
        echo "Error: No files specified" >&2
        return 1
    }

    echo "Verbose: $verbose, Output: ${output:-<stdout>}"
    for file in "$@"; do
        [ "$verbose" = true ] && echo "Processing: $file" || echo "  $file"
    done
}

echo "Basic usage: -v -o results.txt data.txt log.txt"
process_files -v -o "results.txt" "data.txt" "log.txt"

echo ""
echo "Help flag: -h"
process_files -h
