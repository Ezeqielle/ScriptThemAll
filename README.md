# ScriptThemAll

> [!NOTE]
> This repo is actually a work in progress, so if you find any bug or have any suggestion please open an issue or a pull request

## Description

This script is used to install a palworld server and some other tools to manage it.

> [!IMPORTANT]
> If you want to install the [discord Bot](https://github.com/Ly-sec/PalBot/tree/main) feature go read more about it on [@Ly-sec](https://github.com/Ly-sec/PalBot/tree/main) github

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
- [x] Create cron task to shutdown > backups > restart server (linux only)
- [ ] Automate server's update
- [ ] Script for auto-restart
- [ ] Make the repo for windows too (.ps1 script)

## Credits

- PalBot [@Ly-sec](https://github.com/Ly-sec/PalBot/tree/main)
- ARRCON [@radj307](https://github.com/radj307/ARRCON)

## Authors

[@Ezeqielle](https://github.com/Ezeqielle)
