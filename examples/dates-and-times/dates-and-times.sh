#!/bin/sh

: # The `date` command is the primary tool for working
: # with dates and times in shell scripts.

: # Current date and time:

echo "Current date and time:"
date

: # Format output with + and format specifiers:

echo "Formatted outputs:"
echo "  ISO format: $(date '+%Y-%m-%d')"
echo "  US format: $(date '+%m/%d/%Y')"
echo "  Time: $(date '+%H:%M:%S')"
echo "  Full: $(date '+%Y-%m-%d %H:%M:%S')"

: # Common format specifiers:
: # %Y - Year (4 digits)
: # %m - Month (01-12)
: # %d - Day (01-31)
: # %H - Hour (00-23)
: # %M - Minute (00-59)
: # %S - Second (00-59)
: # %A - Full weekday name
: # %B - Full month name
: # %Z - Timezone

echo "More formats:"
echo "  Day: $(date '+%A')"
echo "  Month: $(date '+%B')"
echo "  Timezone: $(date '+%Z')"
echo "  Unix timestamp: $(date '+%s')"

: # Timestamp for filenames (safe characters):

filename="backup_$(date '+%Y%m%d_%H%M%S').tar.gz"
echo "Filename: $filename"

: # Get specific components:

year=$(date '+%Y')
month=$(date '+%m')
day=$(date '+%d')
echo "Components: year=$year, month=$month, day=$day"

: # Day of week (1-7, Monday=1):

dow=$(date '+%u')
echo "Day of week: $dow"

: # Day of year (001-366):

doy=$(date '+%j')
echo "Day of year: $doy"

: # Week number:

week=$(date '+%V')
echo "ISO week number: $week"

: # Date arithmetic (GNU date):

echo "Date arithmetic:"
if date -d "tomorrow" >/dev/null 2>&1; then
  # GNU date
  echo "  Tomorrow: $(date -d 'tomorrow' '+%Y-%m-%d')"
  echo "  Yesterday: $(date -d 'yesterday' '+%Y-%m-%d')"
  echo "  Next week: $(date -d '+7 days' '+%Y-%m-%d')"
  echo "  Last month: $(date -d '-1 month' '+%Y-%m-%d')"
elif date -v+1d >/dev/null 2>&1; then
  # BSD/macOS date
  echo "  Tomorrow: $(date -v+1d '+%Y-%m-%d')"
  echo "  Yesterday: $(date -v-1d '+%Y-%m-%d')"
  echo "  Next week: $(date -v+7d '+%Y-%m-%d')"
  echo "  Last month: $(date -v-1m '+%Y-%m-%d')"
else
  echo "  Date arithmetic not available"
fi

: # Convert timestamp to date:

timestamp=1700000000
echo "Convert timestamp $timestamp:"
if date -d "@$timestamp" >/dev/null 2>&1; then
  # GNU date
  echo "  $(date -d "@$timestamp" '+%Y-%m-%d %H:%M:%S')"
elif date -r "$timestamp" >/dev/null 2>&1; then
  # BSD/macOS date
  echo "  $(date -r "$timestamp" '+%Y-%m-%d %H:%M:%S')"
fi

: # Parse a date string:

parse_date="2024-03-15"
echo "Parse date '$parse_date':"
if date -d "$parse_date" >/dev/null 2>&1; then
  # GNU date
  echo "  Day: $(date -d "$parse_date" '+%A')"
  echo "  Timestamp: $(date -d "$parse_date" '+%s')"
fi

: # UTC time:

echo "UTC time: $(date -u '+%Y-%m-%d %H:%M:%S UTC')"

: # Different timezones:

echo "Timezones:"
echo "  Local: $(date '+%H:%M %Z')"
echo "  UTC: $(TZ=UTC date '+%H:%M %Z')"
echo "  New York: $(TZ=America/New_York date '+%H:%M %Z' 2>/dev/null || echo 'N/A')"
echo "  Tokyo: $(TZ=Asia/Tokyo date '+%H:%M %Z' 2>/dev/null || echo 'N/A')"

: # Measure execution time:

measure_time() {
  start=$(date '+%s')
  sleep 1
  end=$(date '+%s')
  elapsed=$((end - start))
  echo "Elapsed: ${elapsed}s"
}
echo "Execution timing:"
measure_time

: # High-resolution timing (if available):

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

: # Compare dates:

compare_dates() {
  date1="$1"
  date2="$2"

  if date -d "$date1" >/dev/null 2>&1; then
    ts1=$(date -d "$date1" '+%s')
    ts2=$(date -d "$date2" '+%s')
  else
    echo "Date comparison requires GNU date"
    return
  fi

  if [ "$ts1" -lt "$ts2" ]; then
    echo "$date1 is before $date2"
  elif [ "$ts1" -gt "$ts2" ]; then
    echo "$date1 is after $date2"
  else
    echo "$date1 equals $date2"
  fi
}

if date -d "2024-01-01" >/dev/null 2>&1; then
  compare_dates "2024-01-01" "2024-06-15"
fi

: # Calculate age/difference:

if date -d "2000-01-15" >/dev/null 2>&1; then
  birth="2000-01-15"
  today=$(date '+%Y-%m-%d')
  birth_ts=$(date -d "$birth" '+%s')
  today_ts=$(date -d "$today" '+%s')
  age_days=$(((today_ts - birth_ts) / 86400))
  echo "Days since $birth: $age_days"
fi

: # Check if date is weekend:

is_weekend() {
  dow=$(date '+%u') # 1=Mon, 7=Sun
  [ "$dow" -eq 6 ] || [ "$dow" -eq 7 ]
}

if is_weekend; then
  echo "Today is a weekend"
else
  echo "Today is a weekday"
fi

: # Generate date range:

echo "Date range (if GNU date):"
if date -d "2024-01-01" >/dev/null 2>&1; then
  current="2024-01-01"
  end="2024-01-05"
  while [ "$current" != "$end" ]; do
    echo "  $current"
    current=$(date -d "$current + 1 day" '+%Y-%m-%d')
  done
fi

: # Relative time description:

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
