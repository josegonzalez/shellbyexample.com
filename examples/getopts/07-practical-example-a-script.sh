#!/bin/sh
# Practical example: A script with multiple options

process_files() {
  OPTIND=1
  verbose=false
  output=""
  format="text"

  while getopts "vo:f:" opt; do
    case "$opt" in
      v) verbose=true ;;
      o) output="$OPTARG" ;;
      f) format="$OPTARG" ;;
      \?)
        echo "Usage: process [-v] [-o output] [-f format] files..."
        return 1
        ;;
    esac
  done
  shift $((OPTIND - 1))

  echo "Settings:"
  echo "  Verbose: $verbose"
  echo "  Output: ${output:-<stdout>}"
  echo "  Format: $format"
  echo "  Files: ${*:-<none>}"
}

echo "Complete example:"
set -- -v -o result.txt -f json input1.txt input2.txt
process_files "$@"
