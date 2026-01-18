#!/bin/sh
# Trap for cleanup of temporary files:

cleanup_tempfile() {
  (
    tmpfile="/tmp/trap_demo_$$"
    trap 'rm -f "$tmpfile"; echo "  Cleaned up $tmpfile"' EXIT

    echo "test data" >"$tmpfile"
    echo "  Created $tmpfile"
    echo "  File exists: $(test -f "$tmpfile" && echo yes || echo no)"
    # Cleanup happens automatically on exit
  )
}

echo "Temp file cleanup demo:"
cleanup_tempfile
