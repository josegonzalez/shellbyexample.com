#!/bin/sh
# Limit concurrent jobs:

echo "Limited concurrency:"
max_jobs=2
running=0

run_with_limit() {
  for i in 1 2 3 4 5; do
    # Wait if at max jobs
    while [ "$running" -ge "$max_jobs" ]; do
      wait -n 2>/dev/null || sleep 0.1
      running=$((running - 1))
    done

    # Start new job
    (
      sleep 1
      echo "  Job $i done"
    ) &
    running=$((running + 1))
  done
  wait
}
run_with_limit
