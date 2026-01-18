#!/bin/sh
# `xargs` is used for batch processing. When the `-I` flag is used,
# it replaces the `{}` with the input from stdin.

printf "file1\nfile2\nfile3\n" | xargs -I {} echo "Processing {}"
