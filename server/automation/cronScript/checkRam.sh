#!/bin/bash

# Name: checkRam.sh
# Description: This script checks the memory usage of the Palworld server and restarts it if the usage exceeds a certain threshold
# Author: Ezeqielle
# Version: 0.0.1
# Last updated: 2024-02-13
# Usage: sudo ./checkRam.sh

########### Get ram data ###########
ram_data() {
    free -m | awk '/^Mem:/ {printf "%.2f", ($3 / $2) * 100}'
}

########### Setup vars ###########
source "$(dirname "$0")/../../config.sh"

########### Implement the log file ###########
source "$(dirname "$0")/../../log.sh"

########### Check memory usage ###########
ram_usage=$(ram_data)
ram_usage_num=$(echo "$ram_usage "| awk '{print int($1)}')
exit_code=$?
if [ $exit_code -ne 0 ]; then
    logMessage "ERROR" "Error getting ram usage: $ram_usage"
    exit 1
else
    if (( ram_usage_num > RAM_THRESHOLD )); then
    logMessage "INFO" "Ram usage exceeds threshold. Sending ARRCON commands to reboot the server..."
    echo "Shutdown $SHUTDOWN_TIMER The_system_has_exceeded_${RAM_THRESHOLD}_ram__usage_will_reboot_in_5_min" | $ARRCON_CONNECT
    else
    logMessage "INFO" "Ram usage is below 80%. Current usage: $ram_usage%"
    logMessage "INFO" "Restart is not needed at this time"
    fi
fi