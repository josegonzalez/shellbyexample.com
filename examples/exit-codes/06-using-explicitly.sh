#!/bin/sh
# Using $? explicitly:

ls /nonexistent 2>/dev/null
status=$?
if [ "$status" -ne 0 ]; then
  echo "ls failed with exit code: $status"
fi
