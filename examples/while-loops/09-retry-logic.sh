#!/bin/sh
# Retry logic is a common pattern for operations that may fail
# temporarily, like network requests or file locks. The loop
# attempts the operation up to a maximum number of times,
# exiting early on success.
#
# In real scripts, you would typically add `sleep` between
# retries to avoid hammering a resource.

max_retries=3
attempt=0
success=false

while [ "$attempt" -lt "$max_retries" ]; do
    attempt=$((attempt + 1))
    echo "Attempt $attempt of $max_retries"

    # Simulate: fail twice, succeed on third try
    if [ "$attempt" -eq 3 ]; then
        success=true
        echo "  Success!"
        break
    fi

    echo "  Failed, will retry..."
done

if [ "$success" = true ]; then
    echo "Operation completed successfully"
else
    echo "All $max_retries attempts failed"
fi
