#!/bin/sh
# Handle EXIT for normal cleanup, plus INT (Ctrl+C) and TERM
# (kill) to ensure cleanup runs on interruption.

cleanup() {
    echo "Cleanup ran"
}

trap cleanup EXIT
trap 'echo "Interrupted!"; exit 1' INT
trap 'echo "Terminated!"; exit 1' TERM

echo "Script handles EXIT, INT, and TERM"
echo "Cleanup always runs via EXIT trap"
