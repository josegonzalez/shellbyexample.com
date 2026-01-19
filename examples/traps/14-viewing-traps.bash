#!/bin/bash
# Use `trap -p` to view currently set traps.

trap 'echo cleanup' EXIT
trap 'echo interrupted' INT

echo "Current traps:"
trap -p | while read -r line; do
    echo "  $line"
done

trap - EXIT INT
