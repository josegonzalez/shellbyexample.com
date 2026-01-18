#!/bin/sh
# Write binary data:

printf '\x48\x65\x6c\x6c\x6f' >/tmp/binary.txt
echo "Binary write: $(cat /tmp/binary.txt)"
