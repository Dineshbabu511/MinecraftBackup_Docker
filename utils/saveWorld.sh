#!/bin/bash

source /usr/local/bin/log.sh

RCON_HOST="localhost"
RCON_PORT=${RCON_PORT:-25575}
RCON_PASS=$RCON_PASSWORD

saveWorld() {
  local PREFIX="$1"

  local UTC_NOW="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
  local COMMIT_MSG="$UTC_NOW - $PREFIX"

  rcon-cli 'tellraw @a {"text":"📂 Backup started!","color":"gold"}'

  sleep 2

  rcon-cli "save-all"

  sleep 2

  log $PREFIX "World successfully saved."

  git -C "$REPO_DIR" add .
  git -C "$REPO_DIR" commit -m "$COMMIT_MSG" || log "AUTOSAVE" "Nothing to commit"

  if ! git -C "$REPO_DIR" push; then
      log $PREFIX "Upstream not set. Setting upstream and retrying push..."

      git -C "$REPO_DIR" push -u origin main
  fi

  log $PREFIX "Autosave successfully deployed."

  rcon-cli 'tellraw @a {"text":"📁 Backup completed!","color":"green"}'
}
