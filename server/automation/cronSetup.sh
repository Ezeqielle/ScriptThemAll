#! /bin/bash

# Name: cronSetup.sh
# Description: This script setup cron jobs for the Palworld server
# Author: Ezeqielle
# Version: 1.0.0
# Last updated: 2024-02-20
# Usage: sudo ./cronSetup.sh

########### Setup vars ###########
cron_script_dir="$HOME/ScriptThemAll/Server/Automation/cronScript"
server_maintenance="$cron_script_dir/serverMaintenance.sh"
check_ram="$cron_script_dir/checkRam.sh"
check_updates="$cron_script_dir/checkUpdates.sh"
check_process="$cron_script_dir/checkProcRunning.sh"

########### Cron job hardcoded ###########
crontab -l > temp_crontab
echo "*/5 * * * * $check_ram" >> temp_crontab
echo "0 0 */2 * * $check_updates" >> temp_crontab
echo "*/5 * * * * $check_process" >> temp_crontab
crontab temp_crontab
rm temp_crontab

########### Setup cron schedule ###########
while true; do   
    read -p  "Enter the cron schedule (in the format: minute hour day_of_month month day_of_week => example: 0 3 * * * every day at 3:00 AM): " cron_schedule
    # Validate the cron schedule
    cron_regex="^[0-9*,/-]+\s+[0-9*,/-]+\s+[0-9*,/-]+\s+[0-9*,/-]+\s+[0-9*,/-]+$"
    if [[ ! $cron_schedule =~ $cron_regex ]]; then
        echo "Invalid cron schedule format. Please enter a valid cron schedule."
    else
        break
    fi
done
# Check if the cron job already exists
if crontab -l | grep -q "$server_maintenance"; then
    echo "Cron job already exists. Modifying..."
    crontab -l | grep -v "$server_maintenance" | crontab -
fi
# Add the cron job with the specified schedule
echo "Adding new cron job..."
(crontab -l ; echo "$cron_schedule $server_maintenance") | crontab -
echo "Cron job added successfully."
