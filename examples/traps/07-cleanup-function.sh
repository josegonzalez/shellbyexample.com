#!/bin/sh
# For complex cleanup, use a function instead of inline commands.
# This keeps the trap readable and allows multi-step cleanup.

cleanup() {
    rm -f "$TMPFILE"
    echo "Cleanup done"
}

TMPFILE=$(mktemp)
trap cleanup EXIT

echo "Created: $TMPFILE"
echo "Working with file..."
