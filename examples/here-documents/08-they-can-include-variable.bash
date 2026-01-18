#!/bin/bash
# They can include variable expansion:

message="Hello, World!"
tr 'a-z' 'A-Z' <<<"$message"
