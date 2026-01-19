#!/bin/sh
# The `*` pattern matches anything. Place it last
# to handle values that don't match other patterns.
# This acts like a default or "else" branch.

animal="cat"

case $animal in
    dog)
        echo "It's a dog"
        ;;
    bird)
        echo "It's a bird"
        ;;
    *)
        echo "Unknown animal: $animal"
        ;;
esac
