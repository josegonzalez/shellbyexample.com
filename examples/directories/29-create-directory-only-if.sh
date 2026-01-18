#!/bin/sh
# Create directory only if it doesn't exist:

ensure_dir() {
  [ -d "$1" ] || mkdir -p "$1"
}

ensure_dir /tmp/ensured
echo "Ensured /tmp/ensured exists"
