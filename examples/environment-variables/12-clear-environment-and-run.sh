#!/bin/sh
# Clear environment and run with specific vars:

# shellcheck disable=SC2016
env -i PATH="$PATH" sh -c 'echo "Clean env, PATH set: ${PATH:+yes}"'
