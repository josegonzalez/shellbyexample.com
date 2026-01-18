#!/bin/bash
# Pipes connect stdout to stdin. Note that this example is
# bash-specific due to the use of `echo -e`.

echo "Pipeline:"
echo -e "cherry\napple\nbanana" | sort | head -2
