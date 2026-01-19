#!/bin/sh
# Adding a leading `:` to the optstring enables "silent mode".
# In silent mode, getopts doesn't print error messages,
# letting you provide custom ones.
#
# In silent mode:
# - `?` case: unknown option (OPTARG contains the option letter)
# - `:` case: missing required argument (OPTARG contains the option)

demo() {
    name=""
    OPTIND=1
    while getopts ":n:" opt; do
        case "$opt" in
            n) name="$OPTARG" ;;
            :) echo "Error: -$OPTARG requires an argument" ;;
            ?) echo "Error: Unknown option -$OPTARG" ;;
        esac
    done
    [ -n "$name" ] && echo "Name: $name"
}

echo "With unknown option -x:"
demo -x

echo "With missing argument for -n:"
demo -n

echo "With valid -n Alice:"
demo -n "Alice"
