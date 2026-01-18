#!/bin/sh
# GET with query parameters:

echo "Query parameters:"
curl -s "https://httpbin.org/get?name=Alice&age=30" | grep -A2 '"args"'
