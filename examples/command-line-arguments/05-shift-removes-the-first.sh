#!/bin/sh
# The `shift` command removes the first argument and shifts
# all remaining arguments down by one position. This is
# useful when processing arguments one at a time, especially
# in loops or after handling an option that takes a value.
#
# `shift N` removes the first N arguments at once.

set -- first second third fourth
echo "Before shift: \$1=$1 \$2=$2 \$3=$3 \$4=$4 (\$#=$#)"

shift
echo "After shift:  \$1=$1 \$2=$2 \$3=$3 (\$#=$#)"

shift 2
echo "After shift 2: \$1=$1 (\$#=$#)"
