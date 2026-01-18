#!/bin/sh
# Background jobs let you run commands asynchronously.
# This is shell's simple form of concurrency.
#
# Run a command in background with `&`.
#`$!` holds the PID of the last background command.

echo "Starting background job..."
sleep 2 &
bg_pid=$!
echo "Background job started with PID: $bg_pid"
