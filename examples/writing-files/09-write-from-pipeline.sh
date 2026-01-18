#!/bin/sh
# Write from pipeline:

echo "Pipeline to file:"
seq 1 5 | grep -v 3 >/tmp/pipeline.txt
cat /tmp/pipeline.txt
