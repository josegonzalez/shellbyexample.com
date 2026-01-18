#!/bin/sh
# Common pattern: Process all arguments with `shift`:

set -- -v --name=test file1.txt file2.txt

echo "Processing arguments with shift:"
while [ $# -gt 0 ]; do
    echo "  Processing: $1"
    shift
done
