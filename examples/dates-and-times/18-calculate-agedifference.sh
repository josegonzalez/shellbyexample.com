#!/bin/sh
# Calculate age/difference:

if date -d "2000-01-15" >/dev/null 2>&1; then
  birth="2000-01-15"
  today=$(date '+%Y-%m-%d')
  birth_ts=$(date -d "$birth" '+%s')
  today_ts=$(date -d "$today" '+%s')
  age_days=$(((today_ts - birth_ts) / 86400))
  echo "Days since $birth: $age_days"
fi
