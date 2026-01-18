#!/bin/bash
# Bash also supports brace expansion for ranges.
# Step values work too: `{1..10..2}` gives `1,3,5,7,9`

echo "Basic range:"
for n in {1..5}; do
    echo "  $n"
done

echo "With step:"
for n in {1..10..2}; do
    echo "  $n"
done
