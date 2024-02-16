#! /bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Log file path
LOG_FILE="$SCRIPT_DIR/scriptThemAll.log"

logMessage() {
    echo "[$(date '+%m-%d-%Y | %H:%M')] - $1" >> "$LOG_FILE"
}
exec >> "$LOG_FILE" 2>&1