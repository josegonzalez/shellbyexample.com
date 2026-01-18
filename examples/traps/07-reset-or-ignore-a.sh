#!/bin/sh
# Reset or ignore a trap:

echo "Ignore and reset trap:"
(
  # Ignore SIGINT (Ctrl+C)
  trap '' INT
  echo "  SIGINT now ignored"

  # Reset to default behavior
  trap - INT
  echo "  SIGINT reset to default"
)
