#!/bin/sh
# Lock files prevent multiple instances of a script from running.
# The trap ensures the lock is released even if the script fails.

lockfile="/tmp/myapp_lock_$$"
release_lock() {
    rm -f "$lockfile"
    echo "Lock released: $lockfile"
}

trap release_lock EXIT

echo $$ >"$lockfile"
echo "Lock acquired: $lockfile"

sleep 1
echo "Work complete"
