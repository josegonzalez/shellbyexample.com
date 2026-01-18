#!/bin/sh
# Common format specifiers:
# %Y - Year (4 digits)
# %m - Month (01-12)
# %d - Day (01-31)
# %H - Hour (00-23)
# %M - Minute (00-59)
# %S - Second (00-59)
# %A - Full weekday name
# %B - Full month name
# %Z - Timezone

echo "More formats:"
echo "  Day: $(date '+%A')"
echo "  Month: $(date '+%B')"
echo "  Timezone: $(date '+%Z')"
echo "  Unix timestamp: $(date '+%s')"
