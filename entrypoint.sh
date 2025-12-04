#!/bin/bash
set -e

source /usr/local/bin/log.sh

ORIGINAL_ENTRYPOINT="/start"

LOG_DIR="/var/log/mc-scripts"
LOG_FILE="$LOG_DIR/entrypoint.log"

shutdown() { 
  log "ENTRYPOINT" "Container finishing, running shutdown.sh..."

  /usr/local/bin/shutdown.sh || true

  exit 0
}

trap shutdown SIGTERM SIGINT

log "ENTRYPOINT" "Running startup script..."

/usr/local/bin/init.sh

log "ENTRYPOINT" "Startup script completed."

INTERVAL_MINUTES=${PERIODIC_INTERVAL:-15}
INTERVAL_SECONDS=$((INTERVAL_MINUTES * 60))

start_periodic_loop() {
  log "PERIODIC" "First execution in $INTERVAL_MINUTES minutes..."

  sleep "$INTERVAL_SECONDS"

  while true; do
    /usr/local/bin/autosave.sh || true

    sleep "$INTERVAL_SECONDS"
  done
}

start_periodic_loop &

tail -F "$LOG_FILE" &

log "ENTRYPOINT" "Starting Minecraft server..."

"$ORIGINAL_ENTRYPOINT" "$@" &
MC_PID=$!

wait $MC_PID
