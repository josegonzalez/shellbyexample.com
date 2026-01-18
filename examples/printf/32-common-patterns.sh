#!/bin/sh
# Common patterns:

# Debug output
debug() {
  printf "[DEBUG] %s: %s\n" "$(date +%H:%M:%S)" "$*" >&2
}
debug "Starting process"

# Log with timestamp
log() {
  printf "[%s] %s\n" "$(date '+%Y-%m-%d %H:%M:%S')" "$*"
}
log "Application started"

echo "Printf examples complete"
