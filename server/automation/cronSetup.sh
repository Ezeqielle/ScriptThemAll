#! /bin/bash

# Name: cronSetup.sh
# Description: This script setup cron jobs for the Palworld server
# Author: Ezeqielle
# Version: 0.0.1
# Last updated: 2024-02-12
# Usage: sudo ./cronSetup.sh

########### Setup vars ###########
server_maintenance="/home/$USER/ScriptThemAll/Server/Automation/serverMaintenance.sh"

########### Setup cron schedule ###########
while true; do   
    read -p "Enter the cron schedule (in the format: minute hour day_of_month month day_of_week => example: 0 3 * * * every day at 3:00 AM): " cron_schedule
    # Validate the cron schedule
    if [[ ! $cron_schedule =~ ^[0-9*,/-]+\s+[0-9*,/-]+\s+[0-9*,/-]+\s+[0-9*,/-]+\s+[0-9*,/-]+$ ]]; then
        echo "Invalid cron schedule format. Please enter a valid cron schedule."
    else
        break
    fi
done
# Check if the cron job already exists
if crontab -l | grep -q "$server_maintenance"; then
    echo "Cron job already exists. Modifying..."
    crontab -l | grep -v "$server_maintenanace" | crontab -
fi
# Add the cron job with the specified schedule
echo "Adding new cron job..."
(crontab -l ; echo "$cron_schedule $server_maintenanace") | crontab -
echo "Cron job added successfully."