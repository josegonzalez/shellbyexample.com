#!/bin/sh
# Compare two files using checksums:

compare_files() {
  if command -v sha256sum >/dev/null 2>&1; then
    hash1=$(sha256sum "$1" | cut -d' ' -f1)
    hash2=$(sha256sum "$2" | cut -d' ' -f1)
  else
    hash1=$(shasum -a 256 "$1" | cut -d' ' -f1)
    hash2=$(shasum -a 256 "$2" | cut -d' ' -f1)
  fi

  if [ "$hash1" = "$hash2" ]; then
    echo "Files are identical"
  else
    echo "Files are different"
  fi
}

cp /tmp/sample.txt /tmp/copy.txt
echo "Compare identical files:"
compare_files /tmp/sample.txt /tmp/copy.txt

echo "Compare different files:"
compare_files /tmp/sample.txt /tmp/other.txt
