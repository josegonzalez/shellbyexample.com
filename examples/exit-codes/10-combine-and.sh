#!/bin/sh
# Combine && and || for simple conditionals:

test -d "/tmp" && echo "/tmp exists" || echo "/tmp missing"
