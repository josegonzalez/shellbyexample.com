#!/bin/sh
# Here-documents are commonly used with commands
# that read from stdin.
# Send mail (example - won't actually send):

send_mail() {
    # readin in stdin
    message=$(cat)
    echo "message: $message"
}

send_mail -s "Report" user@example.com <<EOF
Daily report attached.
Generated on $(date).
EOF
