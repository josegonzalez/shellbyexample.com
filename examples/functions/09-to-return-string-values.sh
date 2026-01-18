#!/bin/sh
# To return string values, use command substitution.

get_greeting() {
    echo "Hello, $1!"
}

message=$(get_greeting "World")
echo "Got: $message"
