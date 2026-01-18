#!/bin/sh
# Top N results:

echo "Top 2 most frequent:"
printf "a\nb\na\nc\na\nb\nd\n" | sort | uniq -c | sort -rn | head -2
