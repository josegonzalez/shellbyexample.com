#!/bin/sh
# Read binary files (not recommended for text processing):

echo "Binary file info:"
ls -l /bin/sh | cut -d' ' -f5-
