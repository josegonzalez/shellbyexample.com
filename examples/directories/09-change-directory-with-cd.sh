#!/bin/sh
# Change directory with `cd`:

mkdir -p /tmp/testdir
original_dir=$(pwd)
cd /tmp/testdir || exit 1
echo "Changed to: $(pwd)"
cd "$original_dir" || exit 1
echo "Back to: $(pwd)"
