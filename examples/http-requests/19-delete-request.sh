#!/bin/sh
# DELETE request:

echo "DELETE request:"
curl -s -X DELETE "https://httpbin.org/delete" | grep '"url"'
