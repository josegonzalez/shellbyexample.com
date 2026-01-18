#!/bin/sh
# Basic authentication:

echo "Basic auth:"
curl -s -u "user:pass" "https://httpbin.org/basic-auth/user/pass" | head -3
