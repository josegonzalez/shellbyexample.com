#!/bin/sh
# Traps can run multiple commands by separating them with
# semicolons.

trap 'echo "Saving..."; echo "Closing..."' EXIT

echo "Working..."
