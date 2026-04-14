#!/usr/bin/env bash
set -euo pipefail

CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
SYSTEMD_DIR="$CONFIG_HOME/systemd/user"
APP_DIR="$CONFIG_HOME/obsidian-headless"
SERVICE_NAME="obsidian-sync.service"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACKAGE_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

mkdir -p "$SYSTEMD_DIR" "$APP_DIR"

install -m 0644 "$PACKAGE_DIR/systemd/$SERVICE_NAME" "$SYSTEMD_DIR/$SERVICE_NAME"

if [[ ! -f "$APP_DIR/obsidian-sync.env" ]]; then
  install -m 0644 "$PACKAGE_DIR/systemd/obsidian-sync.env.example" "$APP_DIR/obsidian-sync.env"
  echo "Created $APP_DIR/obsidian-sync.env"
else
  echo "Keeping existing $APP_DIR/obsidian-sync.env"
fi

systemctl --user daemon-reload

cat <<EOF
Installed $SERVICE_NAME to $SYSTEMD_DIR

Next steps:
1. Edit $APP_DIR/obsidian-sync.env
2. Run: obsidian-syncctl enable
3. Run: obsidian-syncctl start
4. Check: obsidian-syncctl status
EOF
