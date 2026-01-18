#!/bin/sh
# Menu-driven loop example:

echo "Simple menu loop:"
choice=""
attempt=0
while [ "$choice" != "q" ] && [ "$attempt" -lt 3 ]; do
  attempt=$((attempt + 1))
  choice="q" # Simulate user choosing quit
  echo "  Attempt $attempt: User chose '$choice'"
done
