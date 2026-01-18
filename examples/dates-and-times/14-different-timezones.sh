#!/bin/sh
# Different timezones:

echo "Timezones:"
echo "  Local: $(date '+%H:%M %Z')"
echo "  UTC: $(TZ=UTC date '+%H:%M %Z')"
echo "  New York: $(TZ=America/New_York date '+%H:%M %Z' 2>/dev/null || echo 'N/A')"
echo "  Tokyo: $(TZ=Asia/Tokyo date '+%H:%M %Z' 2>/dev/null || echo 'N/A')"
