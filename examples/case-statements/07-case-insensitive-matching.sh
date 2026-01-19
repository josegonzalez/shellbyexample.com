#!/bin/sh
# Case patterns are case-sensitive by default.
# Use `|` to list common variations like yes/Yes/YES.
# This is a common pattern for user input handling.

response="Yes"

case $response in
    y | Y | yes | Yes | YES)
        echo "User said yes"
        ;;
    n | N | no | No | NO)
        echo "User said no"
        ;;
    *)
        echo "Unknown response: $response"
        ;;
esac
