#!/bin/sh
# Format currency:

format_currency() {
  printf "$%.2f\n" "$1"
}
format_currency 1234.56
format_currency 99.99
