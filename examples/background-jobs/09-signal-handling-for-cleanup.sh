#!/bin/sh
# Signal handling for cleanup:

cleanup_jobs() {
  (
    trap 'kill $(jobs -p) 2>/dev/null' EXIT INT TERM

    sleep 10 &
    sleep 10 &
    sleep 10 &

    echo "Started 3 background jobs"
    echo "They will be killed on exit"
    sleep 1
  )
}
cleanup_jobs
