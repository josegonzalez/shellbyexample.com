#!/bin/bash
# Substitution with `${var/pattern/replacement}`.

msg="hello world world"
echo "Replace first: ${msg/world/universe}"
echo "Replace all: ${msg//world/universe}"
echo "Replace at start: ${msg/#hello/hi}"
echo "Replace at end: ${msg/%world/planet}"
