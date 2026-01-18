#!/bin/sh
# The optstring `vn:` means:
#
# - `v` - flag (no argument)
# - `n:` - option with required argument (colon after)

demo_optstring() {
  OPTIND=1
  verbose=false
  name=""

  # 'v' takes no argument, 'n:' requires one
  while getopts "vn:" opt; do
    case "$opt" in
    v) verbose=true ;;
    n) name="$OPTARG" ;;
    esac
  done

  echo "verbose=$verbose, name=$name"
}

echo "With -v flag only:"
set -- -v
demo_optstring "$@"

echo "With -n option and argument:"
set -- -n "Bob"
demo_optstring "$@"

echo "With both -v and -n:"
set -- -v -n "Charlie"
demo_optstring "$@"
