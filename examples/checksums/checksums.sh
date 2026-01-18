#!/bin/sh

: # Checksums verify file integrity and detect changes.
: # Common algorithms include MD5, SHA-1, SHA-256, and SHA-512.

: # Create sample files for demonstration:

echo "Hello, World!" >/tmp/sample.txt
echo "Different content" >/tmp/other.txt

: # MD5 checksum (not cryptographically secure, but fast):

echo "MD5 checksums:"
if command -v md5sum >/dev/null 2>&1; then
  # GNU/Linux
  md5sum /tmp/sample.txt
elif command -v md5 >/dev/null 2>&1; then
  # macOS/BSD
  md5 /tmp/sample.txt
fi

: # SHA-1 checksum (deprecated for security, still used):

echo "SHA-1 checksums:"
if command -v sha1sum >/dev/null 2>&1; then
  sha1sum /tmp/sample.txt
elif command -v shasum >/dev/null 2>&1; then
  shasum -a 1 /tmp/sample.txt
fi

: # SHA-256 checksum (recommended):

echo "SHA-256 checksums:"
if command -v sha256sum >/dev/null 2>&1; then
  sha256sum /tmp/sample.txt
elif command -v shasum >/dev/null 2>&1; then
  shasum -a 256 /tmp/sample.txt
fi

: # SHA-512 checksum (highest security):

echo "SHA-512 checksums:"
if command -v sha512sum >/dev/null 2>&1; then
  sha512sum /tmp/sample.txt
elif command -v shasum >/dev/null 2>&1; then
  shasum -a 512 /tmp/sample.txt
fi

: # Get just the hash value (no filename):

echo "Hash only:"
if command -v sha256sum >/dev/null 2>&1; then
  sha256sum /tmp/sample.txt | cut -d' ' -f1
elif command -v shasum >/dev/null 2>&1; then
  shasum -a 256 /tmp/sample.txt | cut -d' ' -f1
fi

: # Verify a checksum:

echo "Verify checksum:"

# Create checksum file
if command -v sha256sum >/dev/null 2>&1; then
  sha256sum /tmp/sample.txt >/tmp/checksum.txt
  echo "  Verification result:"
  sha256sum -c /tmp/checksum.txt
elif command -v shasum >/dev/null 2>&1; then
  shasum -a 256 /tmp/sample.txt >/tmp/checksum.txt
  echo "  Verification result:"
  shasum -c /tmp/checksum.txt
fi

: # Verify multiple files:

echo "Multiple file verification:"
if command -v sha256sum >/dev/null 2>&1; then
  sha256sum /tmp/sample.txt /tmp/other.txt >/tmp/checksums.txt
  sha256sum -c /tmp/checksums.txt
elif command -v shasum >/dev/null 2>&1; then
  shasum -a 256 /tmp/sample.txt /tmp/other.txt >/tmp/checksums.txt
  shasum -c /tmp/checksums.txt
fi

: # Detect file modification:

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

: # Restore sample file:

echo "Hello, World!" >/tmp/sample.txt

: # Hash a string (not a file):

echo "Hash a string:"
echo -n "password123" | sha256sum 2>/dev/null || echo -n "password123" | shasum -a 256

: # Note: -n prevents trailing newline which changes the hash

: # Compare two files using checksums:

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

: # CRC32 checksum (fast, not secure):

if command -v cksum >/dev/null 2>&1; then
  echo "CRC checksum:"
  cksum /tmp/sample.txt
fi

: # BSD-style checksums:

if command -v sum >/dev/null 2>&1; then
  echo "BSD sum:"
  sum /tmp/sample.txt
fi

: # Using openssl for checksums:

if command -v openssl >/dev/null 2>&1; then
  echo "OpenSSL checksums:"
  echo "  MD5: $(openssl md5 /tmp/sample.txt 2>/dev/null | awk '{print $NF}')"
  echo "  SHA256: $(openssl sha256 /tmp/sample.txt 2>/dev/null | awk '{print $NF}')"
fi

: # Hash directory contents:

echo "Directory checksum:"
tmpdir=$(mktemp -d)
echo "file1" >"$tmpdir/a.txt"
echo "file2" >"$tmpdir/b.txt"

# Hash all files and then hash the result
if command -v sha256sum >/dev/null 2>&1; then
  find "$tmpdir" -type f -exec sha256sum {} \; | sort | sha256sum
else
  find "$tmpdir" -type f -exec shasum -a 256 {} \; | sort | shasum -a 256
fi
rm -rf "$tmpdir"

: # Verify downloaded file:

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

: # Cleanup

rm -f /tmp/sample.txt /tmp/other.txt /tmp/copy.txt
rm -f /tmp/checksum.txt /tmp/checksums.txt

echo "Checksums examples complete"
