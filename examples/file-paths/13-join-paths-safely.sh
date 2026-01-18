#!/bin/sh
# Join paths safely:

join_path() {
    # Remove trailing slash from first, leading from second
    printf '%s/%s\n' "${1%/}" "${2#/}"
}

echo "Joined: $(join_path "/home/user" "documents")"
echo "Joined: $(join_path "/home/user/" "/documents")"
