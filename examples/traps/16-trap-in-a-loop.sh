#!/bin/sh
# Trap in a loop (handle `Ctrl+C` gracefully):

graceful_loop() {
  (
    running=true
    trap 'running=false; echo "  Stopping..."' INT TERM

    count=0
    while [ "$running" = true ] && [ "$count" -lt 3 ]; do
      count=$((count + 1))
      echo "  Iteration $count"
      sleep 1
    done
    echo "  Loop finished gracefully"
  )
}

echo "Graceful loop termination:"
graceful_loop
