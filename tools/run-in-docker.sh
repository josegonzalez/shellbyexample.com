#!/bin/bash
# Run a script safely inside the shellbyexample Docker container
set -euo pipefail

# Default network mode (none for security)
NETWORK_MODE="none"

# Parse optional flags
while getopts "n" opt; do
    case $opt in
        n) NETWORK_MODE="bridge" ;;
        *) ;;
    esac
done
shift $((OPTIND-1))

if [ $# -lt 1 ]; then
    echo "Usage: $0 [-n] <script> [args...]" >&2
    echo "  -n  Enable network access (use bridge network instead of none)" >&2
    exit 1
fi

SCRIPT="$1"
shift

if [ ! -f "$SCRIPT" ]; then
    echo "Error: Script not found: $SCRIPT" >&2
    exit 1
fi

SCRIPT_NAME=$(basename "$SCRIPT")
SCRIPT_DIR=$(cd "$(dirname "$SCRIPT")" && pwd)

# Determine the shell to use based on file extension
if [[ "$SCRIPT_NAME" == *.bash ]]; then
    SHELL_CMD="bash"
else
    SHELL_CMD="sh"
fi

docker run --rm \
    --read-only \
    --network "$NETWORK_MODE" \
    --memory=128m \
    --cpus=0.5 \
    --tmpfs /tmp:rw,size=64m \
    -v "$SCRIPT_DIR/$SCRIPT_NAME:/script:ro" \
    -w /tmp \
    shellbyexample:latest \
    timeout 10 "$SHELL_CMD" /script "$@" 2>&1
