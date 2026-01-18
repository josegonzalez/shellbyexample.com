#!/bin/sh
# Variables in functions are global by default.
# Be careful with naming to avoid conflicts.

counter=0

increment() {
    counter=$((counter + 1))
}

increment
increment
echo "Counter: $counter"
