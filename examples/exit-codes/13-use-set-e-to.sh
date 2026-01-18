#!/bin/sh
# Use `set -e` to exit on first error:

echo "Without set -e:"
(
  false
  echo "  This still runs"
)

echo "With set -e:"
(
  set -e
  true
  echo "  This runs"
  # false would cause exit here
)
