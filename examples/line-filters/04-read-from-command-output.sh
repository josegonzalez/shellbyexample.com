#!/bin/sh
# Read from command output:

echo "Reading from command:"
find /tmp -maxdepth 1 -type f -exec ls -la {} + 2>/dev/null | head -5 | while read -r line; do
    echo "  $line"
done
