#!/bin/sh
# Basic getopts usage:

demo_basic() {
  # Reset OPTIND for each demo function
  OPTIND=1

  verbose=false
  name=""

  while getopts "vn:" opt; do
    case "$opt" in
      v) verbose=true ;;
      n) name="$OPTARG" ;;
      ?)
        echo "Usage: cmd [-v] [-n name]"
        return 1
        ;;
    esac
  done

  echo "Verbose: $verbose"
  echo "Name: ${name:-<not set>}"
}

echo "Basic getopts demo:"
set -- -v -n "Alice"
demo_basic "$@"
