#!/bin/sh
# Read from URL (using curl or wget):
# network: required
set -eo pipefail

content="$(curl -s https://example.com || echo "Error: curl failed")"
# show the first 4 lines
echo "$content" | head -n 4
content="$(wget -qO- https://example.com || echo "Error: wget failed")"
# show the first 4 lines
echo "$content" | head -n 4
