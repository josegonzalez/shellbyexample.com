#!/bin/sh
# Random password generation:

generate_password() {
  length="${1:-16}"
  cat /dev/urandom | LC_ALL=C tr -dc 'a-zA-Z0-9!@#$%^&*' | head -c "$length"
  echo
}

echo "Random passwords:"
echo "  Simple: $(generate_password 12)"
echo "  Long: $(generate_password 24)"
