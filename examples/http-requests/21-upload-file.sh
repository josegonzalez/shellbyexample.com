#!/bin/sh
# Upload file:

echo "test content" >/tmp/upload.txt
echo "Upload file:"
curl -s -X POST "https://httpbin.org/post" \
  -F "file=@/tmp/upload.txt" | grep -A3 '"files"'
rm /tmp/upload.txt
