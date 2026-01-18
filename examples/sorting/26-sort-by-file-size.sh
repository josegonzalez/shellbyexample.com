#!/bin/sh
# Sort by file size:

echo "Files by size:"
ls -l /tmp/*.txt 2>/dev/null | sort -k5 -n | tail -3
