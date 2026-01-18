#!/bin/sh
# You can also use seq if available:

echo "Using seq:"
for n in $(seq 1 3); do
    echo "  Number: $n"
done
