#!/bin/sh
# EXIT traps run even when scripts exit with an error. This
# ensures cleanup happens regardless of how the script ends.

trap 'echo "Cleanup ran"' EXIT

echo "About to exit with error..."
exit 1
