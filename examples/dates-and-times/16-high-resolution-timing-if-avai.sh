#!/bin/sh
# High-resolution timing (if available):

if command -v gdate >/dev/null 2>&1; then
  # macOS with coreutils
  start=$(gdate '+%s.%N')
  sleep 0.1
  end=$(gdate '+%s.%N')
  echo "High-res: ${start} to ${end}"
elif date '+%N' 2>/dev/null | grep -qv 'N'; then
  # GNU date
  start=$(date '+%s.%N')
  sleep 0.1
  end=$(date '+%s.%N')
  elapsed=$(echo "$end - $start" | bc)
  echo "High-res elapsed: ${elapsed}s"
fi
