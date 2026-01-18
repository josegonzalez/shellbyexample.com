#!/bin/sh
# Wait for specific process:

(
  sleep 1
  echo "  Process 1 done"
) &
pid1=$!
(
  sleep 2
  echo "  Process 2 done"
) &
pid2=$!

echo "Waiting for process $pid1..."
wait $pid1
echo "Process $pid1 finished"

echo "Waiting for all..."
wait
