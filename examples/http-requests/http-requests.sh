#!/bin/sh

: # Shell can make HTTP requests using `curl` or `wget`.
: # curl is more common and feature-rich for scripting.

: # Check if curl is available:

if ! command -v curl >/dev/null 2>&1; then
  echo "curl is not installed"
  exit 1
fi

: # Basic GET request:

echo "GET request:"
curl -s "https://httpbin.org/get" | head -10

: # The -s flag suppresses progress output.

: # Save response to file:

curl -s -o /tmp/response.json "https://httpbin.org/get"
echo "Saved to file:"
head -5 /tmp/response.json
rm /tmp/response.json

: # Get only HTTP status code:

echo "Status code only:"
status=$(curl -s -o /dev/null -w '%{http_code}' "https://httpbin.org/status/200")
echo "Status: $status"

: # GET with query parameters:

echo "Query parameters:"
curl -s "https://httpbin.org/get?name=Alice&age=30" | grep -A2 '"args"'

: # Or use --data-urlencode for encoding:

curl -s -G "https://httpbin.org/get" \
  --data-urlencode "query=hello world" | grep -A2 '"args"'

: # POST request with form data:

echo "POST form data:"
curl -s -X POST "https://httpbin.org/post" \
  -d "name=Alice" \
  -d "age=30" | grep -A5 '"form"'

: # POST with JSON:

echo "POST JSON:"
curl -s -X POST "https://httpbin.org/post" \
  -H "Content-Type: application/json" \
  -d '{"name":"Alice","age":30}' | grep -A5 '"json"'

: # Custom headers:

echo "Custom headers:"
curl -s "https://httpbin.org/headers" \
  -H "X-Custom-Header: MyValue" \
  -H "Authorization: Bearer token123" | grep -E '"X-Custom|Authorization"'

: # Follow redirects with -L:

echo "Follow redirects:"
curl -s -L -o /dev/null -w '%{url_effective}\n' "https://httpbin.org/redirect/1"

: # Set timeout:

echo "With timeout:"
if curl -s --connect-timeout 5 --max-time 10 "https://httpbin.org/delay/1" >/dev/null; then
  echo "  Request completed"
fi

: # Download file:

echo "Download file:"
curl -s -O "https://httpbin.org/robots.txt" 2>/dev/null && {
  head -2 robots.txt
  rm robots.txt
}

: # Resume download with -C -:
: # curl -C - -O "https://example.com/large-file.zip"

: # Basic authentication:

echo "Basic auth:"
curl -s -u "user:pass" "https://httpbin.org/basic-auth/user/pass" | head -3

: # Bearer token authentication:

curl -s "https://httpbin.org/bearer" \
  -H "Authorization: Bearer mytoken" | head -3

: # PUT request:

echo "PUT request:"
curl -s -X PUT "https://httpbin.org/put" \
  -H "Content-Type: application/json" \
  -d '{"key":"value"}' | grep -A3 '"json"'

: # DELETE request:

echo "DELETE request:"
curl -s -X DELETE "https://httpbin.org/delete" | grep '"url"'

: # PATCH request:

echo "PATCH request:"
curl -s -X PATCH "https://httpbin.org/patch" \
  -d "field=value" | grep -A2 '"form"'

: # Upload file:

echo "test content" >/tmp/upload.txt
echo "Upload file:"
curl -s -X POST "https://httpbin.org/post" \
  -F "file=@/tmp/upload.txt" | grep -A3 '"files"'
rm /tmp/upload.txt

: # Response headers:

echo "Response headers:"
curl -s -I "https://httpbin.org/get" | head -5

: # Both headers and body:

curl -s -i "https://httpbin.org/get" | head -10

: # Using wget instead of curl:

if command -v wget >/dev/null 2>&1; then
  echo "wget example:"
  wget -q -O - "https://httpbin.org/get" | head -5
fi

: # Retry on failure:

echo "Retry on failure:"
curl -s --retry 3 --retry-delay 1 "https://httpbin.org/get" >/dev/null && echo "  Success"

: # Check if URL is accessible:

check_url() {
  if curl -s --head --fail "$1" >/dev/null 2>&1; then
    echo "  $1 is accessible"
  else
    echo "  $1 is not accessible"
  fi
}

echo "URL checks:"
check_url "https://httpbin.org"
check_url "https://httpbin.org/status/404"

: # Parse JSON response:

if command -v jq >/dev/null 2>&1; then
  echo "Parse JSON response:"
  curl -s "https://httpbin.org/get?foo=bar" | jq -r '.args.foo'
fi

: # Send cookies:

echo "Send cookies:"
curl -s -b "session=abc123" "https://httpbin.org/cookies" | grep -A3 '"cookies"'

: # Save and send cookies:

curl -c /tmp/cookies.txt "https://example.com/login"
curl -b /tmp/cookies.txt "https://example.com/protected"

: # Verbose output for debugging:

curl -v "https://httpbin.org/get"

: # HTTPS with certificate verification:

curl --cacert /path/to/ca.crt "https://example.com"
curl -k "https://example.com" # Skip verification (insecure!)

: # Rate limiting (pause between requests):

echo "Rate limited requests:"
for i in 1 2 3; do
  curl -s "https://httpbin.org/get" >/dev/null
  echo "  Request $i completed"
  sleep 1
done

: # Parallel requests with xargs:

echo "url1 url2 url3" | xargs -n1 -P3 curl -sO

: # Handle errors:

echo "Error handling:"
response=$(curl -s -w "\n%{http_code}" "https://httpbin.org/status/500")
body=$(echo "$response" | sed '$d')
code=$(echo "$response" | tail -1)

if [ "$code" -ge 400 ]; then
  echo "  Error: HTTP $code"
else
  echo "  Success: HTTP $code"
fi

echo "HTTP requests examples complete"
