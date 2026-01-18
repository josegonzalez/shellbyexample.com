#!/bin/sh
# getopts only handles short options.
# For long options (--verbose), parse manually:

demo_long_opts() {
  verbose=false
  name=""

  while [ $# -gt 0 ]; do
    case "$1" in
      -v | --verbose)
        verbose=true
        shift
        ;;
      -n | --name)
        name="$2"
        shift 2
        ;;
      --name=*)
        name="${1#--name=}"
        shift
        ;;
      --)
        shift
        break
        ;;
      -*)
        echo "Unknown option: $1"
        return 1
        ;;
      *)
        break
        ;;
    esac
  done

  echo "Verbose: $verbose"
  echo "Name: ${name:-<not set>}"
  echo "Remaining: $*"
}

echo "Long options (manual parsing):"
demo_long_opts --verbose --name=Bob file.txt
