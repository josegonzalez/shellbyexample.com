#!/bin/sh
# Check if command exists before running:

if command -v git >/dev/null 2>&1; then
  echo "git is installed"
else
  echo "git is not installed"
fi
