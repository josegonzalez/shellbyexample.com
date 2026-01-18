#!/bin/sh
# Check if process is running:

sleep 10 &
pid=$!
if kill -0 $pid 2>/dev/null; then
  echo "Process $pid is running"
  kill $pid # Clean up
fi
