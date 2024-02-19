#! /bin/bash

# Name: setupPalServer.sh
# Description: This script install a Palworld server and all its dependencies
# Author: Ezeqielle
# Version: 0.1.3
# Last updated: 2024-02-13
# Usage: sudo ./setupPalServer.sh

########### Install steamcmd ###########
sudo add-apt-repository multiverse
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install steamcmd screen htop wget unzip -y
/usr/games/steamcmd +login anonymous +quit
export PATH="$PATH:/usr/games"

########### Install Palworld server ###########
steamcmd +login anonymous +app_update 2394010 +quit

########### Config the server ###########
# Configure server network settings
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
port_regex="^[0-9]+$"
while true; do
    read -p "Please enter an IPv4 address: " ip
    if is_valid_ipv4 "$ip"; then
        break
    fi
done
while true; do
    read -p "Enter the server port (default: 8211): " server_port 
    if [[ "$server_port" =~ $port_regex ]] && [ "$server_port" -ge 1024 ] && [ "$server_port" -le 65535 ]; then
        break
    fi
done

# Configure server settings
while true; do
    read -p "Enter the server name: " server_name
    if [ -n "$server_name" ]; then
        break
    fi
done
while true; do
    read -p "Enter the server description: " server_description
    if [ -n "$server_description" ]; then
        break
    fi
done
while true; do
    read -s -p "Enter the server password: " server_password
    echo
    if [ -n "$server_password" ]; then
        read -s -p "Repeat the server password: " server_password_repeat
        echo
        if [ "$server_password" = "$server_password_repeat" ]; then
            break
        fi
    fi
done
while true; do
    read -s -p "Enter the server admin password: " server_admin_password
    echo
    if [ -n "$server_admin_password" ]; then
        read -s -p "Repeat the server admin password: " server_admin_password_repeat
        echo
        if [ "$server_admin_password" = "$server_admin_password_repeat" ]; then
            break
        fi
    fi
done

# Configure gameplay settings
while true; do
    read -p "Enter the server max players (1-32): " server_max_players
    if [[ "$server_max_players" =~ $port_regex ]] && [ "$server_max_players" -ge 1 ] && [ "$server_max_players" -le 32 ]; then
        break
    fi
done
penalty_regex="^[1-4]$"
while true; do
    read -p "Select death penalty (dropAll(1), dropEquipmentAndItem(2), dropOnlyItem(3), dropNothing(4)): " death_penalty
    case $death_penalty in
        1)
            death_penalty="All"
            break
            ;;
        2)
            death_penalty="ItemAndEquipement"
            break;;
        3)
            death_penalty="Item"
            break
            ;;
        4)
            death_penalty="None"
            break
            ;;
        *)
            echo "Invalid input. Please enter a number between 1 and 4." ;;
    esac
    if [[ "$death_penalty" =~ $penalty_regex ]]; then
        break
    fi
done
while true; do
    read -p "Change xp rate (default: 1): " xp_rate
    if [[ "$xp_rate" =~ $port_regex ]]; then
        break
    fi
done
time_regex="^[1-9][0-9]*$"
while true; do
    read -p "Change Egg max hatch time (default: 72(in hour)): " egg_max_hatch_time
    if [[ "$egg_max_hatch_time" =~ $time_regex ]]; then
        break
    fi
done

# Configure Rcon
while true; do
    read -p "Do you want to enable Rcon? (yes/no): " enable_rcon
    case $enable_rcon in
        yes|Yes|YES|y|Y)
            enable_rcon=true
            break
            ;;
        no|No|NO|n|N)
            enable_rcon=false
            break
            ;;
    esac
done
if [ "$enable_rcon" = true ]; then
    while true; do
        read -p "Enter the Rcon port (default: 25575): " rcon_port 
        if [[ "$rcon_port" =~ $port_regex ]] && [ "$rcon_port" -ne "$server_port" ] && [ "$rcon_port" -ge 1024 ] && [ "$rcon_port" -le 65535 ]; then
            break
        fi
    done
fi

########### Initiate server files ###########
screen -dmS intiate /home/$USER/Steam/steamapps/common/PalServer/PalServer.sh
kill $(pgrep PalServer.sh)

########### patch steamclient.so issues ###########
mkdir -p ~/.steam/sdk64/
steamcmd +login anonymous +app_update 1007 +quit
cp ~/Steam/steamapps/common/Steamworks\ SDK\ Redist/linux64/steamclient.so ~/.steam/sdk64/

# Palworld server config
config_folder=~/Steam/steamapps/common/PalServer/Pal/Saved/Config/LinuxServer
config_file=./PalWorldSettings.ini

# Implement config
sed -i "s/ADP/$server_admin_password/" $config_file
sed -i "s/SRP/$server_password/" $config_file
sed -i "s/\"SP\"/$server_port/" $config_file
sed -i "s/SIP/$ip/" $config_file
sed -i "s/SRD/$server_description/" $config_file
sed -i "s/SRN/$server_name/" $config_file
sed -i "s/\"MP\"/$server_max_players/" $config_file
sed -i "s/\"DP\"/$death_penalty/" $config_file
sed -i "s/\"XP\"/$xp_rate/" $config_file
sed -i "s/\"EMHT\"/$egg_max_hatch_time/" $config_file
sed -i "s/\"RP\"/$rcon_port/" $config_file
sed -i "s/\"RE\"/$enable_rcon/" $config_file

# Add the config to the server
cp PalWorldSettings.ini $config_folder

########### Chmod all script ###########
directory="$(dirname "$0")"
exclude_file="config.sh"
find "$directory" -type f -name '*.sh' ! -name "$exclude_file" -exec chmod +x {} +

########### Setup backup ###########
while true; do
    read -p "Do you want to backup your server to a remote storage ? (yes/no): " setup_backup
    case $setup_backup in
        yes|Yes|YES|y|Y)
            echo "Checking if dependencies are installed..."
            if ! command -v jq &> /dev/null; then
                apt install jq -y
            fi
            if ! command -v sshpass &> /dev/null; then
                apt install sshpass -y
            fi
            echo "all dependencies are installed"
            echo "Setting up backup..."
            if [ -d "$HOME/backups" ]; then
                echo "The backups folder already exists"
            else
                echo "Creating the backups folder..."
                mkdir "$HOME"/backups
            fi
            while true; do
                read -p"Enter the remote username: " remote_username
                if [ -n "$remote_username" ]; then
                    break
                fi
            done
            while true; do
                read -p -s "Enter the path to the private key for ssh: " private_key
                if [ -n "$private_key" ]; then
                    break
                fi
            done
            while true; do
                read -p "Enter the remote host IP: " remote_host
                if [ -n "$remote_host" ]; then
                    break
                fi
            done
            while true; do
                read -p "Enter remote Path" remote_path
                if [ -n "$remote_path" ]; then
                    break
                fi
            done
            sed -i "s/NO/EN/" ./config.sh
            sed -i "s/RMU/$remote_username/" ./config.sh
            sed -i "s/PRK/$private_key/" ./config.sh
            sed -i "s/RMH/$remote_host/" ./config.sh
            sed -i "s/RMP/$remote_path/" ./config.sh
            ;;
        no|No|NO|n|N)
            echo "Remote backup will not be setup."
            break
            ;;
        *)
            echo "Invalid input. Please enter 'yes' or 'no'."
            ;;
    esac
done

########### Setup maintenance automation ###########
while true; do
    read -p  "Do you want to setup the server maintenance automation ? (yes/no): " setup_automation
    case $setup_automation in
        yes|Yes|YES|y|Y)
            echo "Setting up automation..."
            file_path="/usr/local/bin/ARRCON"
            if [ -e "$file_path" ]; then
                echo "ARRCON is already installed in /usr/local/bin."
            else
                echo "ARRCON is not found in /usr/local/bin."
                echo "Installing ARRCON..."
                wget https://github.com/radj307/ARRCON/releases/download/3.3.7/ARRCON-3.3.7-Linux.zip -P /tmp
                sudo unzip /tmp/ARRCON-3.3.7-Linux.zip -d /usr/local/bin
            fi
            # Setup cron
            ./automation/cronSetup.sh
            # Setup config file for RCON
            sed -i "s/password/$server_admin_password/" ./config.sh
            sed -i "s/25575/$rcon_port/" ./config.sh
            break
            ;;
        no|No|NO|n|N)
            echo "Auto maintenance will not be setup"
            break
            ;;
        *)
            echo "Invalid input. Please enter 'yes' or 'no'."
            ;;
    esac
done

########### Setup Alias ###########
echo "Setting up alias..."
alias palworld='/home/$USER/Steam/steamapps/common/PalServer/PalServer.sh -port=${server_port} -players=${server_max_players} -useperfthreads -NoAsyncLoadingThread -UseMultithreadForDS'
echo "Alias 'palworld' is now set"

########### Start the server ###########
echo "Starting the server..."
screen -dmS PalServer /home/$USER/Steam/steamapps/common/PalServer/PalServer.sh -port=${server_port} -players=${server_max_players} -useperfthreads -NoAsyncLoadingThread -UseMultithreadForDS
echo "Palworld server is now running"

########### Install bot ###########
read -p  "Do you want to install the discord bot? (yes/no): " install_bot
case $install_bot in
    yes|Yes|YES|y|Y)
        echo "Starting installation..."
        chmod +x ../bot/setupBot.sh
        sudo ../bot/setupBot.sh
        ;;
    no|No|NO|n|N)
        echo "Exiting..."
        exit
        ;;
    *)
        echo "Invalid input. Please enter 'yes' or 'no'."
        ;;
esac
