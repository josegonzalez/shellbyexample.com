#!/bin/sh
# POSIX alternative using named pipes:

compare_sorted() {
    tmp1=$(mktemp)
    tmp2=$(mktemp)
    trap 'rm -f "$tmp1" "$tmp2"' EXIT

    printf "b\na\nc\n" | sort >"$tmp1"
    printf "c\na\nd\n" | sort >"$tmp2"
    echo "Diff of sorted inputs:"
    diff "$tmp1" "$tmp2" || true
}
compare_sorted
