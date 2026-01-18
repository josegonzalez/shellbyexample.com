#!/bin/sh
# Set variable for a single command:

GREETING="Hola" sh -c 'echo "Temporary: $GREETING"'
echo "After command: GREETING=${GREETING:-<unset>}"
