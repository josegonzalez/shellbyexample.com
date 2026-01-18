#!/bin/sh
# Wait for a specific job:

echo "Waiting for job $bg_pid..."
wait $bg_pid
echo "Job finished with status: $?"
