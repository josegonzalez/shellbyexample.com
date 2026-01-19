#!/bin/sh
# Track resources in variables so the cleanup function knows
# what to clean up, even if resources are created dynamically.

TEMP_FILES=""

add_temp() {
    TEMP_FILES="$TEMP_FILES $1"
}

cleanup_all() {
    for f in $TEMP_FILES; do
        echo "Cleaning up $f"
        rm -f "$f" 2>/dev/null
    done
    echo "All resources cleaned"
}
trap cleanup_all EXIT

f1=$(mktemp)
add_temp "$f1"
f2=$(mktemp)
add_temp "$f2"
echo "Tracking:$TEMP_FILES"
