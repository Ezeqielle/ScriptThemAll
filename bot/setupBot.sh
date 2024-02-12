#! /bin/bash

# Name: setupBot.sh
# Description: This script installs Node.js and sets up the bot
# Author: Ezeqielle
# Version: 0.1.2
# Last updated: 2024-02-07
# Usage: sudo ./setupBot.sh

########### Check if the script is run as root ###########
if [ "$EUID" -ne 0 ]
then
	echo "Usage: sudo ./setupBot.sh"
	echo "Run with sudo or as root"
	exit
fi

########### Install Node.js ###########
version=$(hostnamectl | grep "Operating System" | awk '{print $3}' | awk -F. '{print $1}')
if [ $version == "Ubuntu" ] || [ $version == "Pop!_OS" ] || [ $version == "Debian" ]; then
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && apt-get install -y nodejs
else
    echo "Unsupported OS"
fi

# Clone repo from github
cd /home/$USER
git clone https://github.com/Ly-sec/PalBot.git
cd PalBot && npm install
rm config.json
touch config.json
cat >> config.json << EOF
{
  "token": "BOT_TOKEN",
  "host": "SERVER_IP",
  "port": "SERVER_PORT",
  "rcon_port": "RCON_PORT",
  "rcon_password": "RCON_PASSWORD",
  "rcon_role": "RCON_ROLE",
  "whitelist_role": "WHITELIST_ROLE",
  "whitelist_enabled": "WHITELIST_CHECK",
  "whitelist_time": "WHITELIST_CHECK_TIME"
}
EOF

########### Set up the bot ###########
# check if a string is a valid IPv4 address
is_valid_ipv4() {
    local ip="$1"
    local ipv4_regex="^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
    
    if [[ "$ip" =~ $ipv4_regex ]]; then
        echo "Valid IPv4 address: $ip"
        return 0
    else
        echo "Invalid IPv4 address: $ip"
        return 1
    fi
}

# Prompt the user for an IP address until a valid one is entered
while true; do
    read -p "Please enter an IPv4 address: " ip
    if is_valid_ipv4 "$ip"; then
        break
    fi
done

# Prompt the user for a token until a non-empty one is entered
while true; do
    read -p "Please enter the discord bot token: " token
    if [ -n "$token" ]; then
        break
    fi
done

# Prompt the user for server port until a valid one is entered
while true; do
    read -p "Please enter the server port (default: 8211): " port
    if [[ "$port" =~ ^[0-9]+$ ]] && [ "$port" -ge 1024 ] && [ "$port" -le 65535 ]; then
        break
    fi
done

# Prompt the user for Rcon port until a valid one is entered
while true; do
    read -p "Please enter the Rcon port (default: 25575) : " rcon_port
    if [[ "$rcon_port" =~ ^[0-9]+$ ]] && [ "$rcon_port" -ne "$port" ] && [ "$rcon_port" -ge 1024 ] && [ "$rcon_port" -le 65535 ]; then
        break
    fi
done

# Prompt the user for Rcon password until a non-empty one is entered
while true; do
    read -s -p "Please enter the Rcon password: " rcon_password
    echo
    if [ -n "$rcon_password" ]; then
        break
    fi
done

# Prompt the user for Rcon discord role until a non-empty one is entered
while true; do
    read -p "Please enter the Rcon discord role: " rcon_role
    if [ -n "$rcon_role" ]; then
        break
    fi
done

# Prompt the user if they want to enable whitelist
while true; do
    read -p "Do you want to enable whitelist? (yes/no): " enable_whitelist
    case $enable_whitelist in
        yes|Yes|YES|y|Y)
            enable_whitelist=true
            break
            ;;
        no|No|NO|n|N)
            enable_whitelist=false
            break
            ;;
    esac
done

# Prompt the user for whitelist discord role until a non-empty one is entered if whitelist is enabled
if [ "$enable_whitelist" = true ]; then
    read -p "Please enter the whitelist discord role (if empty same as Rcon role): " whitelist_role
    if [ -n "$whitelist_role" ]; then
        whitelist_role=$rcon_role
    fi

    # Prompt the user for whitelist check time until a valid one is entered
    while true; do
        read -p "Please enter the whitelist check time (in minutes): " whitelist_check_time
        if [[ "$whitelist_check_time" =~ ^[0-9]+$ ]] && [ "$whitelist_check_time" -ge 1 ]; then
            break
        fi
    done
fi

########### Edit the config file ##########
# Edit token => "token": "BOT_TOKEN"
sed -i "s/BOT_TOKEN/$token/g" config.json
# Edit host => "host": "SERVER_IP"
sed -i "s/SERVER_IP/$ip/g" config.json
# Edit port => "port": "SERVER_PORT"
sed -i "s/\"SERVER_PORT\"/$port/g" config.json
# Edit rconPort => "rconPort": "RCON_PORT"
sed -i "s/\"RCON_PORT\"/$rcon_port/g" config.json
# Edit rconPassword => "rconPassword": "RCON_PASSWORD"
sed -i "s/RCON_PASSWORD/$rcon_password/g" config.json
# Edit rconRole => "rconRole": "RCON_ROLE"
sed -i "s/RCON_ROLE/$rcon_role/g" config.json
# Edit whitelistRole => "whitelistRole": "WHITELIST_ROLE"
sed -i "s/WHITELIST_ROLE/$whitelist_role/g" config.json
# Edit enableWhitelist => "enableWhitelist": "true/false"
sed -i "s/\"WHITELIST_CHECK\"/\"$enable_whitelist\"/g" config.json
# Edit whitelistCheckTime => "whitelistCheckTime": "WHITELIST_CHECK_TIME"
sed -i "s/\"WHITELIST_CHECK_TIME\"/\"$whitelist_check_time\"/g" config.json

########### Start the bot ###########
screen -dmS PalBot node .