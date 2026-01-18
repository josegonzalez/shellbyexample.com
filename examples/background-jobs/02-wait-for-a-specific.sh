#!/bin/sh
# Wait for specific process can be done with `wait` command.
#
# The syntax is:
#   wait <pid>
#
# If the process is finished, the exit status is 0.
# Otherwise, the exit status is 1.
#
# If no pid is provided, `wait` will wait for all processes.

echo "Starting background job..."
sleep 2 &
bg_pid=$!
echo "Background job started with PID: $bg_pid"

echo "Waiting for job $bg_pid..."
wait $bg_pid
echo "Job finished with status: $?"
