#!/bin/sh
# Multiple `dirname` calls go up the tree:

path="/home/user/documents/report.txt"
echo "Parent: $(dirname "$(dirname "$path")")"
