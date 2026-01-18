#!/bin/sh
# Build JSON from loop:

echo "Build from loop:"
{
  echo '['
  first=true
  for i in 1 2 3; do
    $first || echo ','
    first=false
    printf '{"num":%d}' "$i"
  done
  echo ']'
} | jq '.'
