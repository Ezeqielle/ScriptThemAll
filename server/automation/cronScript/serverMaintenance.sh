#! /bin/bash

# Name: serverMaintenance.sh
# Description: This script will do the maintenance of the Palworld server that includes updating the server, restarting the server and backing up its data
# Author: Ezeqielle
# Version: 0.0.1
# Last updated: 2024-02-12
# Usage: sudo ./serverMaintenance.sh

########### Setup vars ###########
source "$(dirname "$0")/../../config.sh"

########### Shutdown the server ###########
echo "Shutting down the server..."
echo "Save" | $ARRCON_CONNECT
echo "Shutdown ${SHUTDOWN_TIMER} The_server_will_shutdown_in_${SHUTDOWN_TIMER}_seconds" | $ARRCON_CONNECT

########### Backup the server data ###########
./../backups/backupServer.sh

########### Start the server ###########
echo "Starting the server..."
screen -dmS PalServer palworld
echo "Palworld server is now running"