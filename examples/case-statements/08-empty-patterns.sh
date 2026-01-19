#!/bin/sh
# Sometimes you want to explicitly do nothing for
# certain patterns. Use an empty block or just `:`.
# The `:` command is a shell builtin that does nothing.

log_level="debug"

case $log_level in
    debug)
        # Intentionally do nothing for debug in production
        :
        ;;
    info)
        echo "Info: Application started"
        ;;
    error)
        echo "Error: Something went wrong"
        ;;
esac

echo "Logging complete"
