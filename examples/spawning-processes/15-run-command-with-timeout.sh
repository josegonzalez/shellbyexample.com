#!/bin/sh
# Run command with timeout:

if command -v timeout >/dev/null 2>&1; then
  echo "Timeout demo:"
  timeout 1 sleep 5 || echo "  Command timed out"
fi
