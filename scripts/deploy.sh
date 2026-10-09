#!/usr/bin/env bash
# deploy.sh - pulls the latest code from GitHub onto the server and logs the result.
# Run by hand, by cron, or by the GitHub Actions workflow over SSH.
set -euo pipefail

REPO_DIR="$HOME/Server-Admin-azure-lab"
BRANCH="main"
LOG_FILE="$HOME/deploy.log"

log() { echo "$(date '+%Y-%m-%d %H:%M:%S') | $1" | tee -a "$LOG_FILE"; }
trap 'log "Deploy FAILED at line $LINENO"' ERR

# Only one deploy at a time
exec 9>/tmp/deploy.lock
flock -n 9 || { log "Another deploy is already running, exiting"; exit 1; }

cd "$REPO_DIR"
OLD=$(git rev-parse --short HEAD)
log "Deploy started (current commit: $OLD)"

git checkout "$BRANCH"
git pull --ff-only origin "$BRANCH"

NEW=$(git rev-parse --short HEAD)
if [ "$OLD" = "$NEW" ]; then
  log "Already up to date ($NEW)"
else
  AUTHOR=$(git log -1 --pretty=format:'%an')
  MSG=$(git log -1 --pretty=format:'%s')
  log "Updated $OLD -> $NEW | last commit by $AUTHOR: $MSG"
fi

# Optional: reload your app or web server here, for example:
# sudo systemctl reload apache2

log "Deploy finished"
