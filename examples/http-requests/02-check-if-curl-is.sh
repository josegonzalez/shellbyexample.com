#!/bin/sh
# Check if curl is available:

if ! command -v curl >/dev/null 2>&1; then
  echo "curl is not installed"
  exit 1
fi
