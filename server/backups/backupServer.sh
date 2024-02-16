#! /bin/bash

# Name: backupServer.sh
# Description: Backups .../Saved/ from palworld server
# Author: Ezeqielle
# Version: 0.0.1
# Last updated: 2024-02-12
# Usage: sudo ./backupServer.sh

########### Define path ###########
palworld=~/Steam/steamapps/common/PalServer/Pal/Saved
backups=$HOME/backups
date=$(date +%Y%m%d_%H%M%S)

########### Implement the log file ###########
source "$(dirname "$0")/../../log.sh"

########### Archives server vars###########
source "$(dirname "$0")/../config.sh"

########### Backup server local###########
logMessage "Starting backup..."
tar -czf "${backups}/backup_${date}.tar.gz" -C "${palworld}" .
logMessage "Backup of ${palworld} completed at ${backups}/backup_${date}.tar.gz"

########### Achive remotely ###########
if [ "$REMOTE_ENABLED" = "EN" ]; then
    logMessage "Start sending the backup to the remote server..."
    scp -i "$PRIVATE_KEY" "$backups/backup_${date}.tar.gz" "$REMOTE_USERNAME@$REMOTE_HOST:$REMOTE_PATH"
else
    logMessage "Remote backup is not enabled. Exiting..."
    exit
fi
