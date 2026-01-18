#!/bin/sh
# Repeat a string:

repeat_char() {
    char="$1"
    count="$2"
    result=""
    i=0
    while [ "$i" -lt "$count" ]; do
        result="$result$char"
        i=$((i + 1))
    done
    echo "$result"
}

echo "Repeat '-' 20 times: $(repeat_char '-' 20)"
