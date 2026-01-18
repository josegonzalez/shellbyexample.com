#!/bin/sh
# Default values for missing arguments:
#
# - `${var:-default}` uses default if var is unset or empty
# - `${var:=default}` also assigns the default to var

# Using :- (doesn't modify the variable)
unset name
echo "Hello, ${name:-Guest}"
echo "name is still: '${name}'"

# Using := (assigns the default)
unset name
echo "Hello, ${name:=Guest}"
echo "name is now: '${name}'"

# Common use: default argument values
set -- "customvalue"
name="${1:-default_name}"
port="${2:-8080}"
echo "Name: $name, Port: $port"
