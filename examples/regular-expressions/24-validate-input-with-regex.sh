#!/bin/sh
# Validate input with regex:

validate_email() {
  echo "$1" | grep -qE "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
}

if validate_email "test@example.com"; then
  echo "Valid email"
fi

if ! validate_email "invalid-email"; then
  echo "Invalid email"
fi
