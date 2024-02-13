#! /bin/bash

# Name: serverUpdates.sh
# Description: This script will do the maintenance of the Palworld server that includes updating the server, restarting the server and backing up its data
# Author: Ezeqielle
# Version: 0.0.1
# Last updated: 2024-02-12
# Usage: sudo ./serverUpdates.sh

########### Setup vars ###########
arrcon_port=$(jq -r '.arrcon_port' config.json)
arrcon_password=$(jq -r '.arrcon_password' config.json)
arrcon_host=$(jq -r '.arrcon_host' config.json)
shutdown_timer=$(jq -r '.shutdown_timer' config.json)

########### Shutdown the server ###########
echo "Shutting down the server..."
echo "Save" | ARRCON -H $arrcon_host -P $arrcon_port -p $arrcon_password
echo "Shutdown ${shutdown_timer} The_server_will_shutdown_in_${shutdown_timer}_seconds" | ARRCON -H $arrcon_host -P $arrcon_port -p $arrcon_password

########### Backup the server data ###########
./../backups/backupServer.sh

########### Update the server ###########
#Soon implemented

########### Start the server ###########
echo "Starting the server..."
screen -dmS PalServer palworld
echo "Palworld server is now running"