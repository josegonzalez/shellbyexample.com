#!/bin/bash
# Check if variable is exported:

if declare -p VAR 2>/dev/null | grep -q 'declare -x'; then
    echo "VAR is exported"
fi
