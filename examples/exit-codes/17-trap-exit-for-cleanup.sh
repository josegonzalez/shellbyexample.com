#!/bin/sh
# Trap `EXIT` for cleanup regardless of exit code:

cleanup_demo() {
  (
    trap 'echo "  Cleanup runs on exit"' EXIT
    echo "  Doing work..."
    # Even with errors, cleanup runs
  )
}
echo "Trap EXIT demo:"
cleanup_demo
