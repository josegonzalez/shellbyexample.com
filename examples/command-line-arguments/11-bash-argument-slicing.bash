#!/bin/bash
# Bash provides additional syntax for working with arguments:
#
# - `${@:n}` - All arguments starting at position n
# - `${@:n:m}` - Slice of m arguments starting at position n
# - `${!#}` - The last argument (indirect expansion)
#
# These are useful when you need to skip the first few
# arguments or access the last one directly. Note: These
# features are Bash-specific and not available in POSIX sh.

show_slicing() {
    echo "All arguments: $*"
    echo "Last argument (\${!#}): ${!#}"
    echo "Skip first (\${@:2}): ${*:2}"
    echo "Args 2-3 (\${@:2:2}): ${*:2:2}"
}

show_slicing one two three four five
