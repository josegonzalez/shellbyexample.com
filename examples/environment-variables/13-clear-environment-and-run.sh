#!/bin/sh
# Clear environment and run with specific vars:

env -i PATH="$PATH" sh -c 'echo "Clean env, PATH set: ${PATH:+yes}"'
