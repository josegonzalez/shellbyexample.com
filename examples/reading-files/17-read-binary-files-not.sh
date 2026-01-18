#!/bin/sh
# Read binary files (not recommended for text processing):

echo "Binary file info:"
wc -c </bin/sh | xargs printf "Size: %s bytes\n"
