#!/bin/bash

# Name: checkUpdates.sh
# Description: This script checks for updates on database and update the server if needed
# Author: Ezeqielle
# Version: 0.0.1
# Last updated: 2024-02-13
# Usage: sudo ./checkUpdates.sh

########### Implement the log file ###########
source "$(dirname "$0")/../../log.sh"

########### Load conf file ###########
source "$(dirname "$0")/../../config.sh"

########### Update the server ###########
function updateServer() {
    # Shutdown the server 
    logMessage "Shutting down the server..."
    echo "Save" | $ARRCON_CONNECT
    echo "Shutdown ${SHUTDOWN_TIMER} The_server_will_shutdown_in_${SHUTDOWN_TIMER}_seconds" | $ARRCON_CONNECT

    # Backup the server data
    ./../backups/backupServer.sh

    # Update the server
    logMessage "Updating the server..."
    /usr/games/steamcmd +login anonymous +app_update 2394010 +quit

    # Start the server
    logMessage "Starting the server..."
    screen -dmS PalServer palworld
    logMessage "Palworld server is now running"
}

########### Check new server update ###########
RSS_FEED_URL="https://steamdb.info/api/PatchnotesRSS/?appid=2394010"
rss_content=$(curl -s "$RSS_FEED_URL")
new_build_number=$(echo "$rss_content" | grep -o '<guid[^>]*>build#[0-9]*' | sed 's/<[^>]*>//g' | sed 's/build#//' | head -n 1)
if [ -n "$new_build_number" ] && [ "$new_build_number" -gt "$LAST_UPDATE" ]; then
    logMessage "New build number found: $new_build_number"
    logMessage "Updating LAST_UPDATE from $LAST_UPDATE to $new_build_number"
    sed -i "s/^LAST_UPDATE=.*/LAST_UPDATE=$new_build_number/" ../../config.sh
    updateServer
else
    logMessage "No new build number found or same as last update."
fi