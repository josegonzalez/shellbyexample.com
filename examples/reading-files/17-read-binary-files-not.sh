#!/bin/sh
# Read binary files (not recommended for text processing):

echo "Binary file info:"
# shellcheck disable=SC2012
ls -l /bin/sh | cut -d' ' -f5-
