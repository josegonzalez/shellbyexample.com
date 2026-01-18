#!/bin/sh
# $() can be nested easily:

echo "Nested: $(basename $(dirname /usr/local/bin))"
