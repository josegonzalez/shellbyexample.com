#!/bin/sh
# Atomic file operations with temp files:

atomic_write() {
    target="$1"
    content="$2"

    tmpfile=$(mktemp "$(dirname "$target")/tmp.XXXXXX")
    echo "$content" >"$tmpfile"
    mv "$tmpfile" "$target"
}

atomic_write /tmp/atomic_test.txt "Atomic content"
cat /tmp/atomic_test.txt
rm /tmp/atomic_test.txt
