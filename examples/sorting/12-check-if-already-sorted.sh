#!/bin/sh
# Check if already sorted with -c:

echo "Check if sorted:"
printf "a\nb\nc\n" | sort -c && echo "  Already sorted"
printf "b\na\nc\n" | sort -c 2>&1 | head -1
