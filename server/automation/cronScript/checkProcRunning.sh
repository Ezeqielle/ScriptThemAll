#!/bin/bash

# Name: checkProcRunning.sh
# Description: This script check is palworld server is running
# Author: Ezeqielle
# Version: 0.0.1
# Last updated: 2024-02-13
# Usage: sudo ./checkProcRunning.sh

# Define the process name
process_name="PalServer.sh"

if pgrep "$process_name" >/dev/null; then
    echo "The process $process_name is running."
else
    echo "The process $process_name is not running."
    echo "Restarting the server..."
    # Restart the server in a screen session
fi
