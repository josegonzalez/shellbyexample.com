#!/bin/sh
# Chain commands based on exit codes:

echo "Using && (run if previous succeeded):"
true && echo "  This runs because true succeeded"
false && echo "  This won't run"

echo "Using || (run if previous failed):"
false || echo "  This runs because false failed"
true || echo "  This won't run"
