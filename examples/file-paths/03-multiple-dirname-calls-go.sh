#!/bin/sh
# Multiple `dirname` calls go up the tree:

echo "Parent: $(dirname "$(dirname "$path")")"
