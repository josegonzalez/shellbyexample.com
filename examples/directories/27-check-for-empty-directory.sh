#!/bin/sh
# Check for empty directory:

is_empty_dir() {
  [ -d "$1" ] && [ -z "$(ls -A "$1")" ]
}

mkdir /tmp/emptydir
if is_empty_dir /tmp/emptydir; then
  echo "/tmp/emptydir is empty"
fi
rmdir /tmp/emptydir
