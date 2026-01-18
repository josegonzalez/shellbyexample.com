#!/bin/sh
# Custom exit codes for different error types:

ERR_INVALID_ARG=1

validate_arg() {
  case "$1" in
    start | stop) return 0 ;;
    *) return "$ERR_INVALID_ARG" ;;
  esac
}

validate_arg "invalid"
code=$?
case $code in
  0) echo "Valid argument" ;;
  "$ERR_INVALID_ARG") echo "Invalid argument (code $code)" ;;
esac
