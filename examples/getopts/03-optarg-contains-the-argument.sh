#!/bin/sh
# `getopts` sets these variables automatically:
#
# - `OPTARG` contains the argument for options with `:`.
# - `OPTIND` is the index of the next argument to process.

demo_optarg() {
    OPTIND=1

    while getopts "n:f:" opt; do
        echo "Option: -$opt, OPTARG: '$OPTARG', OPTIND: $OPTIND"
    done
}

echo "Parsing: -n Alice -f output.txt"
set -- -n "Alice" -f "output.txt"
demo_optarg "$@"

echo ""
echo "After parsing, OPTIND=$OPTIND"
echo "Use 'shift \$((OPTIND - 1))' to access remaining args"
