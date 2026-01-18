#!/bin/sh
# Parse a date string:

parse_date="2024-03-15"
echo "Parse date '$parse_date':"
if date -d "$parse_date" >/dev/null 2>&1; then
  # GNU date
  echo "  Day: $(date -d "$parse_date" '+%A')"
  echo "  Timestamp: $(date -d "$parse_date" '+%s')"
fi
