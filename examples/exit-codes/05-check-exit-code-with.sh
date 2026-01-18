#!/bin/sh
# Check exit code with if statement:

if grep -q "root" /etc/passwd; then
  echo "Found root user (grep returned 0)"
else
  echo "No root user found"
fi
