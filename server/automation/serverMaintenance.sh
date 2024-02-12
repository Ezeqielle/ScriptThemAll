#! /bin/bash

# Name: serverMaintenance.sh
# Description: This script will do the maintenance of the Palworld server that includes updating the server, restarting the server and backing up its data
# Author: Ezeqielle
# Version: 0.0.1
# Last updated: 2024-02-12
# Usage: sudo ./serverMaintenance.sh

########### Update the server ###########
#Soon implemented

########### Shutdown the server ###########
#Soon implemented (using rcon to shutdown the server)

########### Backup the server data ###########
# run ../backups/backupServer.sh
../backups/backupServer.sh

########### Start the server ###########
#screen -dmS PalServer palworld
#echo "Palworld server is now running"