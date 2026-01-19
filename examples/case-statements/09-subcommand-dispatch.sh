#!/bin/sh
# Case statements are commonly used for subcommand dispatch.
# This pattern appears in init scripts and CLI tools
# that support commands like "start", "stop", "restart".

command="status"

case $command in
    start)
        echo "Starting service..."
        ;;
    stop)
        echo "Stopping service..."
        ;;
    restart)
        echo "Restarting service..."
        ;;
    status)
        echo "Service is running"
        ;;
    *)
        echo "Usage: start|stop|restart|status"
        ;;
esac
