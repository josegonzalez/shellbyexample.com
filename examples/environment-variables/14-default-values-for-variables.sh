#!/bin/sh
# Default values for variables:

# ${VAR:-default} - use default if unset or empty
echo "DB_HOST: ${DB_HOST:-localhost}"

# ${VAR:=default} - use default and assign if unset
: "${CACHE_DIR:=/tmp/cache}"
echo "CACHE_DIR: $CACHE_DIR"

# ${VAR:?message} - error if unset or empty
# : "${REQUIRED_VAR:?must be set}"  # Would exit if unset

# ${VAR:+value} - use value if var is set
echo "USER is set: ${USER:+yes}"
echo "UNSET is set: ${UNSET_VAR:+yes}"
