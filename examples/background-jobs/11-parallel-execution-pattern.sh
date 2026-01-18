#!/bin/sh
# Parallel execution pattern:

echo "Parallel execution:"
parallel_demo() {
  task() {
    sleep 1
    echo "Task $1 complete"
  }

  # Start tasks in parallel
  for i in 1 2 3; do
    task "$i" &
  done

  # Wait for all to complete
  wait
  echo "All tasks done"
}
parallel_demo
