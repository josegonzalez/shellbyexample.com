#!/bin/sh
# Run a command in background with &:

echo "Starting background job..."
sleep 2 &
bg_pid=$!
echo "Background job started with PID: $bg_pid"
