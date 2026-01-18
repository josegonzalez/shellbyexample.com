#!/bin/sh
# Practical example: Lock file with cleanup

demo_lockfile() {
  lockfile="/tmp/mylock_$$"

  (
    trap 'rm -f "$lockfile"' EXIT

    echo "  Creating lock: $lockfile"
    echo $$ >"$lockfile"

    echo "  Doing work..."
    sleep 1

    echo "  Lock will be removed on exit"
  )

  echo "  Lock removed: $(test -f "$lockfile" && echo no || echo yes)"
}

echo "Lock file pattern:"
demo_lockfile
