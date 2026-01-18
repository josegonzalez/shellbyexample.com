#!/bin/sh
# Numeric comparisons:
# -eq (equal), -ne (not equal)
# -lt (less than), -le (less or equal)
# -gt (greater than), -ge (greater or equal)

count=5

if [ "$count" -gt 3 ]; then
    echo "Count is greater than 3"
fi
