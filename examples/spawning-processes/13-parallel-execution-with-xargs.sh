#!/bin/sh
# `xargs` can be used to run commands in parallel.
# The `-n1` flag specifies that each argument should be passed to the command as a separate word,
# and the `-P3` flag specifies that up to 3 jobs should run at the same time.
#
# Note that when processing in parallel, the order of the output is not guaranteed.

printf "file1\nfile2\nfile3\n" | xargs -n1 -P3 -I {} echo "Processing {}"
