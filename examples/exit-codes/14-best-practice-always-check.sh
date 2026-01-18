#!/bin/sh
# Best practice: always check critical commands:

if ! command -v ls >/dev/null 2>&1; then
    echo "ls command not found" >&2
    exit 127
fi

echo "Script completed successfully"
