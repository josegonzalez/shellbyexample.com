#!/bin/sh
# Path normalization (remove `.` and `..`):

normalize_path() {
    # Use cd and pwd for normalization
    cd "$1" 2>/dev/null && pwd
}

# Example if directories exist:
echo "Normalized /tmp/.: $(normalize_path "/tmp/.")"
