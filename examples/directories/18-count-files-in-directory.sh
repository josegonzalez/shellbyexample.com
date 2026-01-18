#!/bin/sh
# Count files in directory:

echo "File count: $(find /tmp/findtest -type f | wc -l)"
