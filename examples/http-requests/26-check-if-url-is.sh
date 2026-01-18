#!/bin/sh
# Check if URL is accessible:

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
