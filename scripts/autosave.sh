#!/bin/bash
set -e

source /usr/local/bin/log.sh
source /usr/local/bin/saveWorld.sh

LOG_DIR="/var/log/mc-scripts"
LOG_FILE="$LOG_DIR/autosave.log"

REPO_DIR="/data/$REPO_NAME"

REPO_URL="https://$GITHUB_TOKEN@github.com/$GITHUB_USER/$REPO_NAME.git"

log "AUTOSAVE" "Starting execution..."

git config --global --add safe.directory "$REPO_DIR"
git config --global init.defaultBranch main

if [ ! -d "$REPO_DIR/.git" ]; then
    log "AUTOSAVE" "Repository not created. Initializing new repo at $REPO_DIR..."

    git -C "$REPO_DIR" init

    log "AUTOSAVE" "Adding remote origin: $REPO_URL"
    
    git -C "$REPO_DIR" remote add origin "$REPO_URL"
fi

saveWorld "AUTOSAVE"

log "AUTOSAVE" "Execution completed."
