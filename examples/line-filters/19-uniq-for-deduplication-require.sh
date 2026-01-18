#!/bin/sh
# uniq for deduplication (requires sorted input):

echo "Unique lines:"
printf "a\na\nb\nc\nc\nc\n" | uniq

echo "Count occurrences:"
printf "a\na\nb\nc\nc\nc\n" | uniq -c
