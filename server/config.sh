#!/bin/bash

########### Remote accès ###########
REMOTE_ENABLED="NO"
REMOTE_USERNAME="RMU"
REMOTE_HOST="RMH"
REMOTE_PATH="RMP"
PRIVATE_KEY="PRK"

########### RCON accès ###########
SHUTDOWN_TIMER=300
ARRCON_PASSWORD="password"
ARRCON_PORT=25575
ARRCON_HOST="127.0.0.1"
ARRCON_CONNECT="ARRCON -H $ARRCON_HOST -P $ARRCON_PORT -p $ARRCON_PASSWORD"

########### Check ram threshold ###########
RAM_THRESHOLD=75

########### Check new server update ###########
LAST_UPDATE=13378465