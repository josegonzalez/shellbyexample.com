#!/bin/sh
# Access remaining arguments after options:

demo_remaining() {
    OPTIND=1
    verbose=false

    while getopts "v" opt; do
        case "$opt" in
            v) verbose=true ;;
            *) echo "Unknown option: -$opt" ;;
        esac
    done

    # Shift past the processed options
    shift $((OPTIND - 1))

    echo "Verbose: $verbose"
    echo "Remaining args: $*"
}

echo "Remaining arguments:"
set -- -v file1.txt file2.txt
demo_remaining "$@"
