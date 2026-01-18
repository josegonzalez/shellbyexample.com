#!/bin/sh

: # Background jobs let you run commands asynchronously.
: # This is shell's simple form of concurrency.

: # Run a command in background with &:

echo "Starting background job..."
sleep 2 &
bg_pid=$!
echo "Background job started with PID: $bg_pid"

: # $! holds the PID of the last background command.

: # Wait for a specific job:

echo "Waiting for job $bg_pid..."
wait $bg_pid
echo "Job finished with status: $?"

: # Wait for all background jobs:

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

: # Check if a job is still running:

sleep 5 &
pid=$!

if kill -0 $pid 2>/dev/null; then
  echo "Process $pid is running"
fi

# Clean up
kill $pid 2>/dev/null
wait $pid 2>/dev/null

: # Run command and capture output later:

: # [bash]
: # In bash, you can use process substitution or coproc

: # Coproc example (bash 4+):
# coproc WORKER {
#     sleep 1
#     echo "Worker done"
# }
# wait $WORKER_PID
# read -r result <&"${WORKER[0]}"
# echo "Result: $result"
: # [/bash]

: # POSIX pattern: Use temp file or named pipe

capture_background() {
  tmpfile=$(mktemp)
  (
    sleep 1
    echo "Background result" >"$tmpfile"
  ) &
  pid=$!

  echo "Doing other work..."
  sleep 0.5
  echo "Still working..."

  wait $pid
  result=$(cat "$tmpfile")
  rm "$tmpfile"
  echo "Got result: $result"
}
capture_background

: # Parallel execution pattern:

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

: # Limit concurrent jobs:

echo "Limited concurrency:"
max_jobs=2
running=0

run_with_limit() {
  for i in 1 2 3 4 5; do
    # Wait if at max jobs
    while [ "$running" -ge "$max_jobs" ]; do
      wait -n 2>/dev/null || sleep 0.1
      running=$((running - 1))
    done

    # Start new job
    (
      sleep 1
      echo "  Job $i done"
    ) &
    running=$((running + 1))
  done
  wait
}
run_with_limit

: # Signal handling for cleanup:

cleanup_jobs() {
  (
    trap 'kill $(jobs -p) 2>/dev/null' EXIT INT TERM

    sleep 10 &
    sleep 10 &
    sleep 10 &

    echo "Started 3 background jobs"
    echo "They will be killed on exit"
    sleep 1
  )
}
cleanup_jobs

: # Job control (interactive shells):

: # In interactive bash:
: # Ctrl+Z suspends foreground job
: # `jobs` lists jobs
: # `fg` brings job to foreground
: # `bg` resumes job in background
: # `fg %1` brings job 1 to foreground

: # [bash]
: # Disown a job (keep running after shell exits):
# sleep 100 &
# disown $!
# Now the job won't be killed when shell exits
: # [/bash]

: # nohup for persistent background jobs:

echo "nohup keeps commands running after logout"
# nohup long_command > output.log 2>&1 &

: # Pipeline with background processing:

echo "Background in pipeline:"
{
  echo "one"
  echo "two"
  echo "three"
} | while read -r line; do
  (echo "Processing: $line") &
done
wait

: # Producer-consumer pattern:

echo "Producer-consumer:"
producer_consumer() {
  fifo=$(mktemp -u)
  mkfifo "$fifo"
  trap 'rm -f "$fifo"' EXIT

  # Producer
  (
    for i in 1 2 3; do
      echo "item$i"
      sleep 0.5
    done
  ) >"$fifo" &
  producer=$!

  # Consumer
  while read -r item; do
    echo "Consumed: $item"
  done <"$fifo"

  wait $producer
}
producer_consumer

: # Check job count:

count_jobs() {
  sleep 5 &
  sleep 5 &
  sleep 5 &

  job_count=$(jobs -p | wc -l)
  echo "Running jobs: $job_count"

  # Clean up
  kill $(jobs -p) 2>/dev/null
  wait 2>/dev/null
}
count_jobs

: # Wait with timeout (using background wait):

wait_with_timeout() {
  timeout=$1
  pid=$2

  (
    sleep "$timeout"
    kill $pid 2>/dev/null
  ) &
  timeout_pid=$!

  if wait $pid 2>/dev/null; then
    kill $timeout_pid 2>/dev/null
    wait $timeout_pid 2>/dev/null
    return 0
  else
    return 1
  fi
}

echo "Wait with timeout:"
(sleep 1) &
test_pid=$!
wait_with_timeout 2 $test_pid && echo "Completed in time"

echo "Background jobs examples complete"
