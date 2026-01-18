#!/bin/sh
# `xargs` can be used as a line processor:

echo "Using xargs:"
printf "file1\nfile2\nfile3\n" | xargs -I {} echo "Processing: {}"
