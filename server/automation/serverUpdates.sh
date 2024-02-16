#! /bin/bash

# Name: serverUpdates.sh
# Description: This script will do the maintenance of the Palworld server that includes updating the server, restarting the server and backing up its data
# Author: Ezeqielle
# Version: 0.0.1
# Last updated: 2024-02-12
# Usage: sudo ./serverUpdates.sh

########### Setup vars ###########
source "$(dirname "$0")/../config.sh"

########### Implement the log file ###########
source "$(dirname "$0")/../../log.sh"

########### Shutdown the server ###########
logMessage "Shutting down the server..."
echo "Save" | $ARRCON_CONNECT
logMessage "Shutdown ${SHUTDOWN_TIMER} The_server_will_shutdown_in_${SHUTDOWN_TIMER}_seconds" | $ARRCON_CONNECT

########### Backup the server data ###########
./../backups/backupServer.sh

########### Update the server ###########
#Soon implemented

########### Start the server ###########
logMessage "Starting the server..."
screen -dmS PalServer palworld
logMessage "Palworld server is now running"