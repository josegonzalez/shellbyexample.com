#!/bin/sh
# Configuration file pattern:

load_config() {
  # Default values
  APP_PORT="${APP_PORT:-3000}"
  APP_HOST="${APP_HOST:-0.0.0.0}"
  APP_DEBUG="${APP_DEBUG:-false}"

  echo "Config:"
  echo "  APP_PORT=$APP_PORT"
  echo "  APP_HOST=$APP_HOST"
  echo "  APP_DEBUG=$APP_DEBUG"
}

echo "Default config:"
load_config

echo "Overridden config:"
APP_PORT=8080 APP_DEBUG=true load_config
