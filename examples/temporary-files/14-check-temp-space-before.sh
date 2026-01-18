#!/bin/sh
# Check temp space before creating large files:

check_temp_space() {
  avail=$(df -P "${TMPDIR:-/tmp}" | awk 'NR==2 {print $4}')
  echo "Available space in temp: $avail KB"
}
check_temp_space
