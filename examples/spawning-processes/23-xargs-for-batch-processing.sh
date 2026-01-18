#!/bin/sh
# xargs for batch processing:

printf "file1\nfile2\nfile3\n" | xargs -I {} echo "Processing {}"
