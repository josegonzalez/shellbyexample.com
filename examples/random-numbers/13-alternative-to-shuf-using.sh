#!/bin/sh
# Alternative to shuf using sort -R:

echo "Using sort -R:"
printf "a\nb\nc\nd\ne\n" | sort -R | head -1
