#!/bin/sh
# Remove nested empty directories:

rmdir -p /tmp/parent/child/grandchild 2>/dev/null || true
echo "Removed nested directories"
