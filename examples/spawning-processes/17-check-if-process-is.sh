#!/bin/sh
# `kill -0` checks if a process is running without sending it a signal.
# If the process is running, the exit status is 0,
# otherwise the exit status is 1.

sleep 10 &
pid=$!
if kill -0 $pid 2>/dev/null; then
    echo "Process $pid is running"
    kill $pid # Clean up
fi
