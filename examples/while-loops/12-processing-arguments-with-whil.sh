#!/bin/sh
# Processing arguments with while and shift:

set -- arg1 arg2 arg3
echo "Processing arguments:"
while [ $# -gt 0 ]; do
  echo "  Arg: $1"
  shift
done
