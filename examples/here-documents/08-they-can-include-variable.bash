#!/bin/bash
# They can include variable expansion:

message="Hello, World!"
tr '[:lower:]' '[:upper:]' <<<"$message"
