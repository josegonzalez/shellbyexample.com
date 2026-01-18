#!/bin/sh
# Handle multiple combined flags:

demo_combined() {
    OPTIND=1
    a=false b=false c=false

    while getopts "abc" opt; do
        case "$opt" in
            a) a=true ;;
            b) b=true ;;
            c) c=true ;;
            *) echo "Unknown option: -$opt" ;;
        esac
    done

    echo "a=$a b=$b c=$c"
}

echo "Combined flags (-abc):"
set -- -abc
demo_combined "$@"
