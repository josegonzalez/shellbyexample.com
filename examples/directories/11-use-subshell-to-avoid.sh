#!/bin/sh
# Use subshell to avoid changing current directory:

(
  cd /tmp/testdir
  echo "In subshell: $(pwd)"
)
echo "Still in: $(pwd)"
