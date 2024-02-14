#! /bin/bash

# Name: activateRemoteBackupSetup.sh
# Description: Setup remote backup for the Palworld server (not in the server setup process)
# Author: Ezeqielle
# Version: 0.0.1
# Last updated: 2024-02-12
# Usage: sudo ./activateRemoteBackupSetup.sh

########### Setup backup ###########
read -p -r "Do you want to backup your server to a remote storage ? (yes/no): " setup_backup
case $setup_backup in
    yes|Yes|YES|y|Y)
        echo "Checking if dependencies are installed..."
        if ! command -v jq &> /dev/null; then
            apt install jq
        fi
        if ! command -v sshpass &> /dev/null; then
            apt install sshpass
        fi
        echo "all dependencies are installed"
        echo "Setting up backup..."
        while true; do
            read -p -r "Enter the remote username: " remote_username
            if [ -n "$remote_username" ]; then
                break
            fi
        done
        while true; do
            read -p -r -s "Enter the path to the private key for ssh: " private_key
            if [ -n "$private_key" ]; then
                break
            fi
        done
        while true; do
            read -p -r "Enter the remote host IP: " remote_host
            if [ -n "$remote_host" ]; then
                break
            fi
        done
        while true; do
            read -p -r "Enter remote Path" remote_path
            if [ -n "$remote_path" ]; then
                break
            fi
        done
        sed -i "s/NO/YES/" ../config.sh
        sed -i "s/RMU/$remote_username/" ../config.sh
        sed -i "s/PRK/$private_key/" ../config.sh
        sed -i "s/RMH/$remote_host/" ../config.sh
        sed -i "s/RMP/$remote_path/" ../config.sh
        ;;
    no|No|NO|n|N)
        echo "Remote backup will not be activated."
        ;;
    *)
        echo "Invalid input. Please enter 'yes' or 'no'."
        ;;
esac