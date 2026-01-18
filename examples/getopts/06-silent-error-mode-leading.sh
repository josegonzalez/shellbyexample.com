#!/bin/sh
# Silent error mode (leading colon):

demo_silent() {
    OPTIND=1

    # Leading : suppresses error messages
    while getopts ":vn:" opt; do
        case "$opt" in
            v) echo "Got -v" ;;
            n) echo "Got -n with value: $OPTARG" ;;
            :) echo "Option -$OPTARG requires an argument" ;;
            \?) echo "Unknown option: -$OPTARG" ;;
        esac
    done
}

echo "Silent mode (handles errors ourselves):"
set -- -v -n -x
demo_silent "$@"
