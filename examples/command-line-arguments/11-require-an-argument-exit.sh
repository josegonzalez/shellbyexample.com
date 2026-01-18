#!/bin/sh
# Require an argument (exit if missing):

require_arg() {
    : "${1:?Error: First argument required}"
    echo "Got required arg: $1"
}

require_arg "provided"
# require_arg  # Would cause an error
