# ScriptThemAll

> [!NOTE]
> This repo is actually a work in progress, so if you find any bug or have any suggestion please open an issue or a pull request.
> 
> This installation script is linux only, if you want a windows version check this repo [YAPS](https://github.com/guzlad/YAPS) made by [@guzlad](https://github.com/guzlad)

## Description

This script is used to install a palworld server and some other tools to manage it like a discord bot, a backup script (local and remote), many cron task to restart/backup/auto-update the server.

> [!IMPORTANT]
> If you want to install the [discord Bot](https://github.com/Ly-sec/PalBot/tree/main) feature go read more about it on [@Ly-sec](https://github.com/Ly-sec) github

<details>
<summary><b><h2>Features<h2></b></summary>

- Install and setup steamcmd
- Install and setup palworld server
- Setup server settings
- Custom PalWorldSettings.ini with markers
- Install of screen
- Git clone of [PalBot](https://github.com/Ly-sec/PalBot/tree/main)
- Script to setup and run the bot
- Backup script
- Option to send backup to remote server
- Auto-update script
- Monitoring script for Ram usage
- Auto-restart script in case of crash

</details>

> [!WARNING]
> To use the remote backup feature you need to have a remote server with ssh access by key not password

## Requirements

- Linux machine or VM (debian or ubuntu)
- git

## Installation

> [!CAUTION]
> This installation script is linux only for now

```bash
git clone https://github.com/Ezeqielle/ScriptThemAll.git
cd ScriptThemAll/server
chmod +x setupPalServer.sh
sudo ./setupPalServer.sh
```

> [!NOTE]
> When you enable the remote backup feature the script will run the first backup and send it to the remote server then **for now** you will need to manually run the script for the next backups
> the script is here: `~/ScriptThemAll/server/backup/backupServer.sh`

<details>
<summary><b><h2>FAQ<h2></b></summary>

- I don't have setup the remote backup feature, how can I do it?

> You need to edit run the remote backup script that can be found here
> `~/ScriptThemAll/server/backup/remoteBackupSetup.sh`

- I don't have a remote server, how can I use the backup feature?

> You can use the local backup feature that is already implemented in the script that can be found here
> `~/ScriptThemAll/server/backup/backupServer.sh`

</details>

## TODO

- [X] Semi-auto install steamcmd and palworld server
- [X] Install and setup discord bot
- [X] Script for backups
- [X] Create cron task to shutdown > backups > restart server (linux only)
- [X] Automate server's update
- [ ] Script for auto-restart
- [X] Monitoring of the Ram usage
- [ ] ~~Make the repo for windows too (.ps1 script)~~ (Check this repo for windows [YAPS](https://github.com/guzlad/YAPS))

## Credits

- PalBot [@Ly-sec](https://github.com/Ly-sec/PalBot/tree/main)
- YAPS [@guzlad](https://github.com/guzlad/YAPS)
- ARRCON [@radj307](https://github.com/radj307/ARRCON)

## Authors

[@Ezeqielle](https://github.com/Ezeqielle)
