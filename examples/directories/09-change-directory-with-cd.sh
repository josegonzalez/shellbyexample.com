#!/bin/sh
# Change directory with `cd`:

mkdir -p /tmp/testdir
original_dir=$(pwd)
cd /tmp/testdir
echo "Changed to: $(pwd)"
cd "$original_dir"
echo "Back to: $(pwd)"
