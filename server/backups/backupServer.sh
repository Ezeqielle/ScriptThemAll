#! /bin/bash

# Name: backupServer.sh
# Description: Backups .../Saved/ from palworld server
# Author: Ezeqielle
# Version: 0.0.1
# Last updated: 2024-02-12
# Usage: sudo ./backupServer.sh

########### Define path ###########
palworld=~/Steam/steamapps/common/PalServer/Pal/Saved
backups=/home/$USER/backups
date=$(date +%Y%m%d_%H%M%S)

########### Archives server vars###########
remote_username=$(jq -r '.remote_username' config.json)
private_key=$(jq -r '.private_key' config.json)
remote_host=$(jq -r '.remote_host' config.json)
remote_path=$(jq -r '.remote_path' config.json)
remote_enable=$(jq -r '.remote_enable' config.json)

########### Backup server local###########
echo "Starting backup..."
tar -czf "${backups}/backup_${date}.tar.gz" -C "${palworld}" .
echo "Backup of ${palworld} completed at ${backup}/backup_${date}.tar.gz"

########### Achive remotely ###########
if [ "$remote_enable" = "EN" ]; then
    case $remote_backup in
        yes|Yes|YES|y|Y)
            echo "Start sending the backup to the remote server..."
            scp -i "$private_key" $backups/backup_${date}.tar.gz $remote_username@$remote_host:$remote_path
            ;;
        no|No|NO|n|N)
            echo "Exiting..."
            exit
            ;;
    esac
else
    echo "Remote backup is not enabled. Exiting..."
    exit
fi
