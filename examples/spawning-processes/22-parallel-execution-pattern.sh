#!/bin/sh
# This example shows how to run multiple tasks in parallel.
#
# The `&` operator runs the command or function in the background,
# and the `wait` command waits for all background jobs to complete.

echo "Parallel execution:"
parallel_demo() {
    task() {
        sleep 1
        echo "Task $1 complete"
    }

    # Start tasks in parallel
    for i in 1 2 3; do
        task "$i" &
    done

    # Wait for all to complete
    wait
    echo "All tasks done"
}
parallel_demo
