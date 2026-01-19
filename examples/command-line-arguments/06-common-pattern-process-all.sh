#!/bin/sh
# A common pattern combines `while` and `shift` to process
# a variable number of arguments. The loop runs as long as
# arguments remain, handling each `$1` then shifting it away.
# This works well for scripts that accept any number of files.

set -- file1.txt file2.txt file3.txt

echo "Processing files:"
while [ $# -gt 0 ]; do
    echo "  Processing: $1"
    shift
done

echo "All files processed (remaining args: $#)"
