#!/bin/bash
# Run a script safely inside the shellbyexample Docker container
set -euo pipefail

if [ $# -lt 1 ]; then
    echo "Usage: $0 <script> [args...]" >&2
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
    --network none \
    --memory=128m \
    --cpus=0.5 \
    --tmpfs /tmp:rw,size=64m \
    -v "$SCRIPT_DIR/$SCRIPT_NAME:/script:ro" \
    -w /tmp \
    shellbyexample:latest \
    timeout 10 "$SHELL_CMD" /script "$@" 2>&1
