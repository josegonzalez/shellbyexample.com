#!/bin/sh
# How to create a lock file with cleanup using `trap`.
#
# 1. Create a lock file with `mktemp`.
# 2. Set up a trap to remove the lock file on exit.
# 3. Do your work.
# 4. The lock file will be removed on exit.

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
