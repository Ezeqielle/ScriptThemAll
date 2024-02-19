#! /bin/bash

# Name: serverMaintenance.sh
# Description: This script will do the maintenance of the Palworld server that includes updating the server, restarting the server and backing up its data
# Author: Ezeqielle
# Version: 0.0.1
# Last updated: 2024-02-12
# Usage: sudo ./serverMaintenance.sh

########### Implement the log file ###########
source "$(dirname "$0")/../../log.sh"

########### Setup vars ###########
source "$(dirname "$0")/../../config.sh"

########### Shutdown the server ###########
logMessage "INFO" "Shutting down the server..."
echo "Save" | $ARRCON_CONNECT
echo "Shutdown ${SHUTDOWN_TIMER} The_server_will_shutdown_in_${SHUTDOWN_TIMER}_seconds" | $ARRCON_CONNECT
logMessage "INFO" "Server is now shutdown"

########### Backup the server data ###########
output=$(./../backups/backupServer.sh)
exit_code=$?
if [ $exit_code -ne 0 ]; then
    logMessage "ERROR" "Error backing up the server: $output"
    exit 1
else
    logMessage "INFO" "Server backup successful."
fi

########### Start the server ###########
logMessage "INFO" "Starting the server..."
output=$(screen -dmS PalServer palworld)
exit_code=$?
if [ $exit_code -ne 0 ]; then
    logMessage "ERROR" "Error starting the server: $output"
    exit 1
else 
    logMessage "INFO" "Palworld server is now running"
fi