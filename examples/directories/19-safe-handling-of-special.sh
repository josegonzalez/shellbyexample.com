#!/bin/sh
# Safe handling of special characters:

mkdir -p "/tmp/spaces dir"
touch "/tmp/spaces dir/file with spaces.txt"
echo "Files with spaces:"
for file in "/tmp/spaces dir"/*; do
  echo "  $file"
done
rm -rf "/tmp/spaces dir"
