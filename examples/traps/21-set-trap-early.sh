#!/bin/sh
# Set the trap before creating resources. This ensures cleanup
# runs even if resource creation fails partway through.

tmpfile=""
cleanup() {
    [ -n "$tmpfile" ] && [ -f "$tmpfile" ] && rm -f "$tmpfile"
    echo "Cleanup complete"
}
trap cleanup EXIT

tmpfile=$(mktemp)
echo "Created: $tmpfile"
echo "Working with file..."
