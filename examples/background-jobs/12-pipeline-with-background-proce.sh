#!/bin/sh
# Pipeline with background processing:

echo "Background in pipeline:"
{
  echo "one"
  echo "two"
  echo "three"
} | while read -r line; do
  (echo "Processing: $line") &
done
wait
