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
    logMessage "The process $process_name is running."
else
    logMessage "The process $process_name is not running."
    logMessage "Restarting the server..."
    # Restart the server in a screen session
fi
