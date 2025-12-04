#!/bin/bash

source /usr/local/bin/log.sh
source /usr/local/bin/saveWorld.sh

LOG_DIR="/var/log/mc-scripts"
LOG_FILE="$LOG_DIR/shutdown.log"

REPO_DIR="/data/$REPO_NAME"

log "SHUTDOWN" "Running shutdown script..."

saveWorld "SHUTDOWN"

log "SHUTDOWN" "Complete closure!"
