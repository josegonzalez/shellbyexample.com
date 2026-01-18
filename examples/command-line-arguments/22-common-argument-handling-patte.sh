#!/bin/sh
# Common argument handling pattern:

handle_args() {
  while [ $# -gt 0 ]; do
    case "$1" in
      -h | --help)
        echo "Usage: script [options] files..."
        return 0
        ;;
      -v | --verbose)
        echo "Verbose mode on"
        shift
        ;;
      --)
        shift
        break # Rest are positional args
        ;;
      -*)
        echo "Unknown option: $1" >&2
        return 1
        ;;
      *)
        break # Start of positional args
        ;;
    esac
  done

  echo "Remaining arguments: $*"
}

handle_args -v -- file1 file2
