#!/bin/bash
# voip_mass_extension_creator.sh
# Create multiple VoIP extensions automatically (for Asterisk/Issabel)

EXT_FILE="extensions_list.txt"

while IFS=',' read -r EXT USER PASS; do
    echo "Creating extension $EXT for user $USER..."
    cat <<EOF >> /etc/asterisk/sip_custom.conf
[$EXT]
type=friend
username=$USER
secret=$PASS
host=dynamic
context=from-internal
EOF
done < "$EXT_FILE"

echo "Reloading Asterisk..."
asterisk -rx "sip reload"
echo "Extensions created successfully!"
