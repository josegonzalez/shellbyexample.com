#!/bin/sh
# Check job count:

count_jobs() {
  sleep 5 &
  sleep 5 &
  sleep 5 &

  job_count="$(jobs -p | wc -l)"
  echo "Running jobs: $job_count"

  # Clean up
  kill "$(jobs -p)" 2>/dev/null
  wait 2>/dev/null
}
count_jobs
