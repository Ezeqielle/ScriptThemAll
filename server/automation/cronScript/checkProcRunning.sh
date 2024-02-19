#!/bin/bash

# Name: checkProcRunning.sh
# Description: This script check is palworld server is running
# Author: Ezeqielle
# Version: 0.0.1
# Last updated: 2024-02-13
# Usage: sudo ./checkProcRunning.sh

########### Implement the log file ###########
source "$(dirname "$0")/../../log.sh"

########### Define the process name ###########
process_name="PalServer.sh"

if pgrep "$process_name" >/dev/null; then
    logMessage "INFO" "The process $process_name is running."
else
    logMessage "INFO" "The process $process_name is not running."
    logMessage "INFO" "Restarting the server..."
    output=$(screen -dmS PalServer palworld)
    exit_code=$?
    if [ $exit_code -ne 0 ]; then
        logMessage "ERROR" "Error starting the server: $output"
        exit 1
    else 
        logMessage "INFO" "Palworld server is now running"
    fi
fi
