#!/bin/sh
# If no PID is provided, `wait` will wait for all processes.

echo "Starting multiple background jobs:"
sleep 1 &
pid1=$!
sleep 1 &
pid2=$!
sleep 1 &
pid3=$!

echo "PIDs: $pid1, $pid2, $pid3"
echo "Waiting for all jobs..."
wait
echo "All jobs finished"
