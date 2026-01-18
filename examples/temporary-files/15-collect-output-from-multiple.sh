#!/bin/sh
# Collect output from multiple processes:

collect_output() {
    tmpdir=$(mktemp -d)
    trap 'rm -rf "$tmpdir"' EXIT

    # Simulate parallel tasks
    echo "result1" >"$tmpdir/task1"
    echo "result2" >"$tmpdir/task2"

    # Collect results
    echo "Collected results:"
    cat "$tmpdir"/*
}
collect_output
