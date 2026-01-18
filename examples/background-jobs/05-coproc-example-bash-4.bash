#!/bin/bash
# In bash, you can use process substitution or coproc to communicate with background jobs.
# This example waits for the background job to finish and reads the result.

coproc WORKER {
    sleep 1
    echo "Worker done"
}
wait $WORKER_PID
read -r result <&"${WORKER[0]}"
echo "Result: $result"
