#! /bin/bash

# Name: log.sh
# Description: This will format and put in scriptThemAll.log all the logs from the cron scripts
# Author: Ezeqielle
# Version: 1.0.0
# Last updated: 2024-02-20
# Usage: sudo ./log.sh

########### Webhook ###########
source ./config.sh
codeBlock="\`\`\`"
errorColor="15548997"
infoColor="5793266"
generateWebhookData() {
    cat <<EOF
{
  "embeds": [{
    "title": "$log_level",
    "description": "$codeBlock $message $codeBlock",
    "color": $color
  }]
}
EOF
}

########### Log ########### 
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
LOG_FILE="$SCRIPT_DIR/scriptThemAll.log"

logMessage() {
    local log_level=$1
    local message=$2
    echo "[$(date '+%m-%d-%Y | %H:%M')] - [$log_level] - $message" >> "$LOG_FILE"
    if [ "$WEBHOOK_ENABLED" == "YES" ]; then
        if [ "$log_level" == "ERROR" ]; then
            color=$errorColor
        else
            color=$infoColor
        fi
        curl -H "Content-Type: application/json" -X POST -d "$(generateWebhookData)" $URL
    fi
}
exec >> "$LOG_FILE" 2>&1