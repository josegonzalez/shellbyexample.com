#!/bin/sh
# Compare dates:

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
