#!/bin/bash
# You should always clean up temp files using `trap`.

demo_trap_cleanup() {
  local tmpfile
  tmpfile=$(mktemp)
  trap 'rm -f "$tmpfile"' EXIT

  echo "Working with $tmpfile"
  echo "data" >"$tmpfile"
  # Even if script exits early, cleanup runs
}
demo_trap_cleanup
