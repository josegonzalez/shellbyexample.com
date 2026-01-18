#!/bin/sh
# Filter with grep before processing:

echo "Pre-filter with grep:"
grep "red" /tmp/data.txt | while read -r fruit count color; do
  echo "  Red fruit: $fruit"
done
