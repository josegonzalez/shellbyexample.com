#!/bin/sh
# Create nested directories with `-p`:

mkdir -p /tmp/parent/child/grandchild
echo "Created nested directories:"
ls -la /tmp/parent/child/
