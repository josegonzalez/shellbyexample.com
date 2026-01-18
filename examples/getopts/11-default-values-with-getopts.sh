#!/bin/sh
# Default values with getopts:

demo_defaults() {
  OPTIND=1
  host="${HOST:-localhost}"
  port="${PORT:-8080}"

  while getopts "h:p:" opt; do
    case "$opt" in
      h) host="$OPTARG" ;;
      p) port="$OPTARG" ;;
    esac
  done

  echo "Host: $host, Port: $port"
}

echo "With defaults:"
demo_defaults
set -- -p 3000
demo_defaults "$@"
