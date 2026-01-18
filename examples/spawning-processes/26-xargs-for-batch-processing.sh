#!/bin/sh
# xargs for batch processing:

echo "xargs demo:"
printf "file1\nfile2\nfile3\n" | xargs -I {} echo "Processing {}"
