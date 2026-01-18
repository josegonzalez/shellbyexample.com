#!/bin/sh
# Run command conditionally:

echo "Conditional execution:"
true && echo "  After success"
false || echo "  After failure"
false && echo "  Won't run"
true || echo "  Won't run"
