#!/bin/sh
# Always clean up temp files - use trap:

demo_trap_cleanup() {
  local tmpfile
  tmpfile=$(mktemp)
  trap 'rm -f "$tmpfile"' EXIT

  echo "Working with $tmpfile"
  echo "data" >"$tmpfile"
  # Even if script exits early, cleanup runs
}
demo_trap_cleanup
