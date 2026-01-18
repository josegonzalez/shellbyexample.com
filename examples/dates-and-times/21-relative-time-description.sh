#!/bin/sh
# Relative time description:

relative_time() {
  seconds="$1"
  if [ "$seconds" -lt 60 ]; then
    echo "${seconds}s ago"
  elif [ "$seconds" -lt 3600 ]; then
    echo "$((seconds / 60))m ago"
  elif [ "$seconds" -lt 86400 ]; then
    echo "$((seconds / 3600))h ago"
  else
    echo "$((seconds / 86400))d ago"
  fi
}

echo "Relative: $(relative_time 45)"
echo "Relative: $(relative_time 3700)"
echo "Relative: $(relative_time 90000)"

echo "Dates and times examples complete"
