#!/bin/sh
# Follow redirects with -L:

echo "Follow redirects:"
curl -s -L -o /dev/null -w '%{url_effective}\n' "https://httpbin.org/redirect/1"
