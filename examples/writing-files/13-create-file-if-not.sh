#!/bin/sh
# Create file if not exists, don't overwrite:

if [ ! -f /tmp/nooverwrite.txt ]; then
    echo "New content" >/tmp/nooverwrite.txt
fi
echo "Safe write (no overwrite): $(cat /tmp/nooverwrite.txt)"
