#!/bin/sh
# `$()` can be nested to achieve more complex operations.

echo "Nested: $(basename "$(dirname /usr/local/bin)")"
