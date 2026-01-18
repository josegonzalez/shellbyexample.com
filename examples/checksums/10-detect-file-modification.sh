#!/bin/sh
# Detect file modification:

echo "Detect modification:"
if command -v sha256sum >/dev/null 2>&1; then
  original=$(sha256sum /tmp/sample.txt | cut -d' ' -f1)
  echo "modified" >>/tmp/sample.txt
  modified=$(sha256sum /tmp/sample.txt | cut -d' ' -f1)

  if [ "$original" = "$modified" ]; then
    echo "  Files are identical"
  else
    echo "  File was modified!"
    echo "  Before: $original"
    echo "  After:  $modified"
  fi
fi
