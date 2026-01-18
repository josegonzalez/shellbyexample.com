#!/bin/sh
# Fallback if mktemp is unavailable:

portable_mktemp() {
  template="${1:-/tmp/tmp.XXXXXX}"
  dir=$(dirname "$template")
  prefix=$(basename "$template" | sed 's/X*$//')

  # Generate random suffix
  suffix=$(awk 'BEGIN{srand(); for(i=1;i<=6;i++) printf "%c", 65+int(rand()*26)}')

  result="$dir/${prefix}${suffix}"
  touch "$result"
  chmod 600 "$result"
  echo "$result"
}

portable_tmp=$(portable_mktemp)
echo "Portable mktemp: $portable_tmp"
rm "$portable_tmp"

echo "Temporary files examples complete"
