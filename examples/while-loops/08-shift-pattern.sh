#!/bin/sh
# The `shift` command removes `$1` and shifts remaining arguments
# down (`$2` becomes `$1`, `$3` becomes `$2`, etc.). Combined with
# `while`, this is the standard pattern for processing an
# unknown number of arguments.
#
# Each `shift` decreases `$#` by 1. The loop continues while
# arguments remain.

set -- apple banana cherry date
echo "Processing $# arguments:"

while [ $# -gt 0 ]; do
    echo "  Current arg: $1 (remaining: $#)"
    shift
done

echo "Done. Arguments remaining: $#"
