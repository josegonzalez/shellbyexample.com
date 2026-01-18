#!/bin/sh
# Check if directory exists with `-d`:

mkdir -p /tmp/testdir
if [ -d "/tmp/testdir" ]; then
  echo "/tmp/testdir exists"
fi
