#!/bin/sh
# Use a flag variable to gracefully exit loops when interrupted,
# allowing the current iteration to complete.

running=true
trap 'running=false; echo "Shutdown requested..."' INT TERM

count=0
while [ "$running" = true ] && [ "$count" -lt 3 ]; do
    count=$((count + 1))
    echo "Processing item $count"
    sleep 1
done

echo "Graceful shutdown complete"
