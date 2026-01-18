#!/bin/sh
# Step values work too: `{1..10..2}` gives `1,3,5,7,9`

for n in {1..10..2}; do
    echo "  $n"
done
