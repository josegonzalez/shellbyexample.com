#!/bin/sh
# curl --cacert /path/to/ca.crt "https://secure-server.example"

echo "HTTPS certificate verification:"
curl -s -k "https://httpbin.org/get" >/dev/null && echo "  -k flag: skipped verification"
