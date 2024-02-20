# ScriptThemAll

![Steam](https://img.shields.io/badge/steam-%23000000.svg?style=flat&logo=steam&logoColor=white)
![Shell Script](https://img.shields.io/badge/shell_script-%23121011.svg?style=flat&logo=gnu-bash&logoColor=white)
![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420?style=flat&logo=ubuntu&logoColor=white)
![Debian](https://img.shields.io/badge/Debian-A81D33?style=flat&logo=debian&logoColor=white)

> [!NOTE]
> This repo is actually a work in progress, so if you find any bug or have any suggestion please open an issue or a pull request *(please comment your code)*
>
> This installation script is linux only, if you want a windows version check this repo [YAPS](https://github.com/guzlad/YAPS) made by [@guzlad](https://github.com/guzlad)

<details>
<summary><b><h2>Table of content<h2></b></summary>

- [ScriptThemAll](#scriptthemall)
  - [Description](#description)
  - [Requirements](#requirements)
  - [Installation](#installation)
  - [TODO](#todo)
  - [Credits](#credits)
  - [License](#license)
  - [Release notes](#release-notes)
  - [Authors](#authors)

</details>

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
- hard coded cron task for:
  - update the server
  - ram threshold
  - auto-restart in case of crash

</details>

> [!WARNING]
> To use the remote backup feature you need to have a remote server with ssh access by key not password

## Requirements

- Linux machine or VM (debian or ubuntu)
- git
- user account with sudo privileges

## Installation

>[!CAUTION]
> Don't run the script as root, run it with your user that can use sudo

> [!NOTE]
> Remote backup part can be activate later by running the **activate** script for this feature *(take a look at the [FAQ](#faq) for more info)*

```bash
git clone https://github.com/Ezeqielle/ScriptThemAll.git
cd ScriptThemAll/server
chmod +x setupPalServer.sh
./setupPalServer.sh
```

>[!TIP]
>If you got an error about the interpreter run this command before in the root folder of the project
>```bash
>find . -type f -name '*.sh' -exec sed -i 's/\r$//' {} \;
>```
>That will remove the carriage return from the script files that can cause the issue

<details>
<summary><b><h2>FAQ<h2></b></summary>

- I don't have setup the remote backup feature, how can I do it?

> You need to run the remote backup script that can be found here
> `~/ScriptThemAll/server/backup/activateRemoteBackupServer.sh`

- I don't have a remote server, how can I use the backup feature?

> Don't worry, you can use the local backup feature that is implemented during the installation

</details>

## TODO

- [X] Semi-auto install steamcmd and palworld server
- [X] Install and setup discord bot
- [X] Script for backups
- [X] Create cron task to shutdown > backups > restart server (linux only)
- [X] Automate server's update
- [X] Script for auto-restart
- [X] Monitoring of the Ram usage
- [X] Log system for the scripts cron task
- [ ] ~~Make the repo for windows too (.ps1 script)~~ (Check this repo for windows [YAPS](https://github.com/guzlad/YAPS))

## Credits

- PalBot [@Ly-sec](https://github.com/Ly-sec/PalBot)
- YAPS [@guzlad](https://github.com/guzlad/YAPS)
- ARRCON [@radj307](https://github.com/radj307/ARRCON)

## License

[MIT](./LICENSE)

## Release notes

[Release notes](./Release.md)

## Authors

[@Ezeqielle](https://github.com/Ezeqielle)
