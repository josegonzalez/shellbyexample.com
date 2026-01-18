#!/bin/sh
# While loop for retry logic:

max_retries=3
retry=0
success=false

while [ "$retry" -lt "$max_retries" ]; do
    retry=$((retry + 1))
    echo "Attempt $retry of $max_retries"

    # Simulate success on third try
    if [ "$retry" -eq 3 ]; then
        success=true
        break
    fi

    echo "  Failed, retrying..."
    sleep 1
done

if [ "$success" = true ]; then
    echo "Succeeded!"
else
    echo "All retries failed"
fi
