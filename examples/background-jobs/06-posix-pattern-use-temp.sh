#!/bin/sh
# POSIX pattern: Use temp file or named pipe

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
