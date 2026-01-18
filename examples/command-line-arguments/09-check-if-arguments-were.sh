#!/bin/sh
# Check if arguments were provided with `-eq 0`:

check_args() {
    if [ $# -eq 0 ]; then
        echo "No arguments provided"
        return 1
    fi
    echo "Got $# argument(s)"
}

check_args
check_args one two
