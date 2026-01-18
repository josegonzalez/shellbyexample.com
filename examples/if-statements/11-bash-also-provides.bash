#!/bin/bash
# Bash also provides `(( ))` for arithmetic evaluation,
# which is cleaner for numeric comparisons:

count=5
if ((count > 3)); then
    echo "Count is greater than 3"
else
    echo "Count is not greater than 3"
fi

x=40
if ((x >= 0 && x <= 100)); then
    echo "x is between 0 and 100"
else
    echo "x is not between 0 and 100"
fi
