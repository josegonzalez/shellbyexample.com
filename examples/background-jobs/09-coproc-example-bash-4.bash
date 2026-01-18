#!/bin/bash
# Coproc example (bash 4+):

coproc WORKER {
    sleep 1
    echo "Worker done"
}
wait $WORKER_PID
read -r result <&"${WORKER[0]}"
echo "Result: $result"
