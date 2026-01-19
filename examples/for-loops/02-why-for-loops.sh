#!/bin/sh
# Loops eliminate repetitive code and let you process
# collections of items. Instead of writing the same
# command multiple times with different values, you
# write it once and let the loop handle each item.
#
# The loop approach is easier to modify, extend, and
# understand when dealing with many items.

echo "Without a loop (repetitive):"
echo "  processing: file1"
echo "  processing: file2"
echo "  processing: file3"

echo ""
echo "With a loop (scalable):"
for file in file1 file2 file3; do
    echo "  processing: $file"
done
