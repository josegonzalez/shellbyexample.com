#!/bin/sh
# Generate date range using epoch arithmetic (portable):

echo "Date range:"
current="2024-01-01"
end="2024-01-05"
while [ "$current" != "$end" ]; do
  echo "  $current"
  # Convert to epoch, add 86400 seconds (1 day), convert back
  epoch=$(date -d "${current} 00:00:00" +%s)
  epoch=$((epoch + 86400))
  current=$(date -d "@$epoch" '+%Y-%m-%d')
done
echo "  $end"
