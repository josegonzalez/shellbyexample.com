#!/bin/sh
# Parallel execution with xargs:

printf "file1\nfile2\nfile3\n" | xargs -n1 -P3 -I {} echo "Processing {}"
