#!/bin/sh
# Wait with timeout (using background wait):

wait_with_timeout() {
  timeout=$1
  pid=$2

  (
    sleep "$timeout"
    kill "$pid" 2>/dev/null
  ) &
  timeout_pid=$!

  if wait "$pid" 2>/dev/null; then
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
