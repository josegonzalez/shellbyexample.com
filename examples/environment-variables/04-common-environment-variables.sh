#!/bin/sh
# The system and shell set several standard environment
# variables. Knowing these helps you write portable
# scripts that adapt to the user's environment.
#
# - `USER`: The current username (set at login)
# - `HOME`: The user's home directory (set at login)
# - `PWD`: The current working directory (updated by cd)
# - `PATH`: Colon-separated list of directories searched
#   for commands (set by shell config files)
# - `SHELL`: The user's default login shell (set at login)
# - `TERM`: The terminal type, used by programs that draw
#   to the screen (set by the terminal emulator)
# - `LANG`: The system locale, controls language and
#   formatting for dates, numbers, etc. (set by OS)

echo "USER:  $USER"
echo "HOME:  $HOME"
echo "PWD:   $PWD"
echo "PATH:  $PATH"
echo "SHELL: $SHELL"
echo "TERM:  $TERM"
echo "LANG:  $LANG"
