#!/bin/sh
# Check if jq is available:

if ! command -v jq >/dev/null 2>&1; then
  echo "jq is not installed. Install it with:"
  echo "  brew install jq      # macOS"
  echo "  apt install jq       # Debian/Ubuntu"
  echo "  yum install jq       # RHEL/CentOS"
  exit 0
fi
