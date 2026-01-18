#!/bin/sh
# The `exit` command sets the script's exit code:

run_check() {
  if [ -f "/etc/passwd" ]; then
    return 0 # Success
  else
    return 1 # Failure
  fi
}

run_check
echo "run_check returned: $?"
