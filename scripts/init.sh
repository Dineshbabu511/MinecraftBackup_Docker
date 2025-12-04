#!/bin/bash

source /usr/local/bin/log.sh

LOG_DIR="/var/log/mc-scripts"
LOG_FILE="$LOG_DIR/init.log"

REPO_DIR="/data/$REPO_NAME"

REPO_URL="https://$GITHUB_TOKEN@github.com/$GITHUB_USER/$REPO_NAME.git"

check_and_process_repo() {
  git config --global --add safe.directory "$REPO_DIR"

  remote_output=$(git ls-remote "$REPO_URL" 2>/dev/null)
  git_status=$?

  if [ $git_status -ne 0 ]; then
      log "INIT" "Repository not found."

      return 0
  fi

  if [ -z "$remote_output" ]; then
      log "INIT" "The repository is empty"

			return 0
  fi

  if [ -d "$REPO_DIR/.git" ]; then
      log "INIT" "Repository already cloned. Syncing..."

      git -C "$REPO_DIR" pull --ff-only

      return 0
  fi

  log "INIT" "Cloning repository..."

  git clone "$REPO_URL" "$REPO_DIR"
}

check_and_process_repo
