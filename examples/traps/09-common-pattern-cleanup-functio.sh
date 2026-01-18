#!/bin/sh
# Common pattern: cleanup function

cleanup() {
  echo "  Performing cleanup..."
  # Remove temp files, kill background processes, etc.
}

robust_script() {
  (
    trap cleanup EXIT
    echo "  Script running"
    # Even if something fails, cleanup runs
  )
}

echo "Cleanup function pattern:"
robust_script
