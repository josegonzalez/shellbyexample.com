#!/bin/sh
# You can also use a pipeline to run commands in background.
#
# This example adds a newline to the end of the pipeline
# to ensure that the last line is processed.

echo "Background in pipeline:"
{
  echo "one"
  echo "two"
  echo "three"
  echo ""
} | while read -r line; do
  if [ -n "$line" ]; then
    (echo "Processing: $line") &
  fi
done
wait
