#!/bin/sh
# In-memory temp file using /dev/shm (Linux):

if [ -d /dev/shm ]; then
    ramtmp=$(mktemp /dev/shm/myapp.XXXXXX)
    echo "RAM-based temp: $ramtmp"
    rm "$ramtmp"
else
    echo "/dev/shm not available"
fi
