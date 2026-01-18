#!/bin/bash
# Bash also provides `(( ))` for arithmetic evaluation,
# which is cleaner for numeric comparisons:

if ((count > 3)); then
    echo "Count is greater than 3"
fi

if ((x >= 0 && x <= 100)); then
    echo "x is between 0 and 100"
fi
