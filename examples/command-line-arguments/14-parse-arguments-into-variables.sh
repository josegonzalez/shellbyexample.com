#!/bin/sh
# Parse arguments into variables with `case`:

set -- source.txt destination.txt --verbose

src="$1"
dst="$2"
verbose=""

for arg in "$@"; do
  case "$arg" in
  --verbose | -v) verbose=true ;;
  esac
done

echo "Source: $src"
echo "Destination: $dst"
echo "Verbose: ${verbose:-false}"
