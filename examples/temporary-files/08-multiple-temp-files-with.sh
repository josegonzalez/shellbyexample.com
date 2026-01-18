#!/bin/sh
# Multiple temp files with cleanup:

cleanup_files() {
    (
        tmpfile1=$(mktemp)
        tmpfile2=$(mktemp)
        tmpdir=$(mktemp -d)
        trap 'rm -f "$tmpfile1" "$tmpfile2"; rm -rf "$tmpdir"' EXIT

        echo "Files: $tmpfile1, $tmpfile2"
        echo "Dir: $tmpdir"
        # Work with temp files...
    )
}
echo "Cleanup demo:"
cleanup_files
