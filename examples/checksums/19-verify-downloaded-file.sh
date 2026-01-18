#!/bin/sh
# Verify downloaded file:

verify_download() {
  file="$1"
  expected_hash="$2"

  if command -v sha256sum >/dev/null 2>&1; then
    actual_hash=$(sha256sum "$file" | cut -d' ' -f1)
  else
    actual_hash=$(shasum -a 256 "$file" | cut -d' ' -f1)
  fi

  if [ "$actual_hash" = "$expected_hash" ]; then
    echo "Download verified successfully"
    return 0
  else
    echo "Checksum mismatch!"
    echo "Expected: $expected_hash"
    echo "Got:      $actual_hash"
    return 1
  fi
}

echo "Simulated download verification:"
expected=$(sha256sum /tmp/sample.txt 2>/dev/null | cut -d' ' -f1 || shasum -a 256 /tmp/sample.txt | cut -d' ' -f1)
verify_download /tmp/sample.txt "$expected"
