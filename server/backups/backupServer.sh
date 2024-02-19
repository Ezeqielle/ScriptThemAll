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
logMessage "INFO" "Starting backup..."
tar -czf "${backups}/backup_${date}.tar.gz" -C "${palworld}" .
logMessage "INFO" "Backup of ${palworld} completed at ${backups}/backup_${date}.tar.gz"

########### Achive remotely ###########
if [ "$REMOTE_ENABLED" = "EN" ]; then
    logMessage "INFO" "Start sending the backup to the remote server..."
    output=$(scp -i "$PRIVATE_KEY" "$backups/backup_${date}.tar.gz" "$REMOTE_USERNAME@$REMOTE_HOST:$REMOTE_PATH")
    exit_code=$?
    if [ $exit_code -ne 0 ]; then
        logMessage "ERROR" "Error sending the backup to the remote server: $output"
        exit 1
    else
        logMessage "INFO" "Backup sent to the remote server."
    fi
else
    logMessage "INFO" "Remote backup is not enabled. Exiting..."
    exit
fi
