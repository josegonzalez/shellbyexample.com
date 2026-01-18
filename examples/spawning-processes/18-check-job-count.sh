#!/bin/sh
# The `jobs` command can be used to get statistics about background jobs.
#
# Note that running `jobs -p` in a subshell - `$()` - will not work
# as it returns background jobs of the current shell, not the parent shell.

count_jobs() {
    sleep 5 &
    sleep 5 &
    sleep 5 &

    jobs -p >/tmp/job_pids.txt
    job_count="$(wc -l </tmp/job_pids.txt)"
    echo "Running jobs: $job_count"

    # Clean up
    kill "$(cat /tmp/job_pids.txt)" 2>/dev/null
    wait 2>/dev/null
}
count_jobs
