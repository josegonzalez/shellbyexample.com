#!/bin/sh
# Log cleanup actions to help debug issues. Check return values
# to report success or failure.

tmpdir=$(mktemp -d)
touch "$tmpdir/file1" "$tmpdir/file2"

cleanup_with_log() {
    if rm -rf "$tmpdir" 2>/dev/null; then
        echo "Cleanup: success"
    else
        echo "Cleanup: failed"
    fi
}
trap cleanup_with_log EXIT

echo "Created: $tmpdir"
echo "Files: $(ls "$tmpdir" | tr '\n' ' ')"
echo "Exiting..."
