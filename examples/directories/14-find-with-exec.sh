#!/bin/sh
# Find with exec:

echo "Find and show sizes:"
find /tmp/findtest -type f -exec ls -la {} \;
