#!/bin/sh
# Sort with uniq for frequency counting:

echo "Word frequency:"
printf "apple\nbanana\napple\napple\ncherry\nbanana\n" | sort | uniq -c | sort -rn
