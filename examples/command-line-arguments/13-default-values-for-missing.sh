#!/bin/sh
# Default values for missing arguments:

set -- customvalue

name="${1:-default_name}"
port="${2:-8080}"
echo "Name: $name, Port: $port"
