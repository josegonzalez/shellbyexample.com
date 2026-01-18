#!/bin/sh
# Check if date is weekend:

is_weekend() {
  dow=$(date '+%u') # 1=Mon, 7=Sun
  [ "$dow" -eq 6 ] || [ "$dow" -eq 7 ]
}

if is_weekend; then
  echo "Today is a weekend"
else
  echo "Today is a weekday"
fi
