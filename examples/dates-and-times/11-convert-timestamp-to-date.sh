#!/bin/sh
# Convert timestamp to date:

timestamp=1700000000
echo "Convert timestamp $timestamp:"
if date -d "@$timestamp" >/dev/null 2>&1; then
  # GNU date
  echo "  $(date -d "@$timestamp" '+%Y-%m-%d %H:%M:%S')"
elif date -r "$timestamp" >/dev/null 2>&1; then
  # BSD/macOS date
  echo "  $(date -r "$timestamp" '+%Y-%m-%d %H:%M:%S')"
fi
