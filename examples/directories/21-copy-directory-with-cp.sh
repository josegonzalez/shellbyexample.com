#!/bin/sh
# Copy directory with `cp -r`:

mkdir -p /tmp/testdir
mkdir -p /tmp/testdir_copy

cp -r /tmp/testdir /tmp/testdir_copy
echo "Copied directory:"
ls /tmp/testdir_copy
