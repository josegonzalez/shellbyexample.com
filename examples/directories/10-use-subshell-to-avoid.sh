#!/bin/sh
# Use subshell to avoid changing current directory:
mkdir -p /tmp/testdir

(
  cd /tmp/testdir || exit 1
  echo "In subshell: $(pwd)"
)
echo "Still in: $(pwd)"
