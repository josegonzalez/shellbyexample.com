#!/bin/sh
# Check if a job is still running:

sleep 5 &
pid=$!

if kill -0 $pid 2>/dev/null; then
  echo "Process $pid is running"
fi

# Clean up
kill $pid 2>/dev/null
wait $pid 2>/dev/null
