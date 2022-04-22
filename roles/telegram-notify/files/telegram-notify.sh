#!/bin/bash

# BUCKET=$1
# CHAN_BACKUP=$2ss

TELEGRAM_BOT_TOKEN=$1

# TOKEN="YOUR_TOKEN" 
ID="-1001443174939"
URL="https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage"

# curl -s -X POST $URL -d chat_id=$ID -d text="Hello World"

FILTER='New outbound peer connected|Main PID:'


FILTER='New outbound peer connected|Main PID:'
cat << EndOfMessage
$(echo systemctl status bitcoind.service|grep -vE "$FILTER" | sed 's;raspberrypi bitcoind;;')
$(echo systemctl status bitcoind.service|grep -vE "$FILTER" )
$(df -h|grep bitcoin)
EndOfMessage

LOG_PREFIX='s;^.*raspberrypi bitcoind\[[0-9]*\]: ;;'
systemctl status bitcoind.service| sed "$LOG_PREFIX"



while true; do
    # curl -X POST \
    #     -H 'Content-Type: application/json' \
    #     -d '{"chat_id": "-1001443174939", "text": "This is a test from curl", "disable_notification": true}' \
    #     https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage
    read -r -d '' MSG << EOF
$(systemctl status bitcoind.service|grep -vE "$FILTER" | sed "$LOG_PREFIX" )
$(df -h|grep bitcoin)
EOF


    curl -s -X POST $URL -d chat_id=$ID -d text="$MSG" > /dev/null 2>&1
    sleep 200
done
