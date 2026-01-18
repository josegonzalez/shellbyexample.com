#!/bin/sh
# Subshells also have their own traps that
# can be used to clean up resources.

cleanup_jobs() {
    (
        sleep 10 &
        sleep 10 &
        sleep 10 &
        jobs -p >/tmp/job_pids.txt
        trap 'cat /tmp/job_pids.txt' EXIT INT TERM

        echo "Started 3 background jobs"
        echo "The pids will be printed out on exit"
        echo "In the normal case, one would kill the pids instead"
        sleep 1
    )
    echo "Subshell finished"
}
cleanup_jobs
