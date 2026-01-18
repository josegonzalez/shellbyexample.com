#!/bin/sh
# Check if command exists in PATH:

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

if command_exists git; then
  echo "git is installed"
fi
