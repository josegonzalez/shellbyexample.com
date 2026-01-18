#!/bin/sh
# Pipes connect stdout to stdin:

echo "Pipeline:"
echo -e "cherry\napple\nbanana" | sort | head -2
