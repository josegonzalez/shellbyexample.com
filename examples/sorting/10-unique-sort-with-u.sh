#!/bin/sh
# Unique sort with -u:

echo "Unique values only:"
printf "apple\nbanana\napple\ncherry\nbanana\n" | sort -u
