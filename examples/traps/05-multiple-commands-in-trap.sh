#!/bin/sh
# Multiple commands in trap:

multi_cmd_trap() {
  (
    trap 'echo "  Step 1: Save state"; echo "  Step 2: Close files"' EXIT
    echo "  Running..."
  )
}

echo "Multi-command trap:"
multi_cmd_trap
