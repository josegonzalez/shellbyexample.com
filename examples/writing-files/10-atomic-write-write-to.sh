#!/bin/sh
# Atomic write (write to temp, then rename):

atomic_write() {
    tmpfile=$(mktemp)
    echo "Important data" >"$tmpfile"
    mv "$tmpfile" "$1"
}

atomic_write /tmp/atomic.txt
echo "Atomic write result: $(cat /tmp/atomic.txt)"
