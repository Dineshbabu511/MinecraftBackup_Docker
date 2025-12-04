#!/bin/bash

DEFAULT_LOG_DIR="/var/log/mc-scripts"
DEFAULT_LOG_FILE="$DEFAULT_LOG_DIR/default.log"

log() {
    local PREFIX="$1"
    shift
    local MSG="$*"

    local TS="$(date '+%Y-%m-%d %H:%M:%S')"
    local TARGET_LOG_FILE="${LOG_FILE:-$DEFAULT_LOG_FILE}"

    mkdir -p "$(dirname "$TARGET_LOG_FILE")"

    echo "[$TS] [$PREFIX] $MSG" >> "$TARGET_LOG_FILE"
}
