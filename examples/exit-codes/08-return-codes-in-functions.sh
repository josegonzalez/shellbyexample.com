#!/bin/sh
# Return codes in functions use `return`, not `exit`.
# `exit` would terminate the entire script.

check_file() {
  [ -f "$1" ] # Return code is the test's result
}

check_file "/etc/passwd"
echo "Check /etc/passwd: $?"

check_file "/nonexistent"
echo "Check /nonexistent: $?"
