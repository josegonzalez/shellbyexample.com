#!/bin/sh
# xargs as line processor:

echo "Using xargs:"
printf "file1\nfile2\nfile3\n" | xargs -I {} echo "Processing: {}"
