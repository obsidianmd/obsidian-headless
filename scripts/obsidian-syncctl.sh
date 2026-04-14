#!/usr/bin/env bash
set -euo pipefail

SERVICE_NAME="obsidian-sync.service"

usage() {
  cat <<'EOF'
Usage: obsidian-syncctl <command>

Commands:
  install   Install or refresh the user service and env file
  enable    Enable the user service
  disable   Disable the user service
  start     Start the user service
  stop      Stop the user service
  restart   Restart the user service
  status    Show service status
  logs      Show service logs
EOF
}

if [[ $# -lt 1 ]]; then
  usage
  exit 1
fi

case "$1" in
  install)
    exec obsidian-sync-install
    ;;
  enable|disable|start|stop|restart|status)
    exec systemctl --user "$1" "$SERVICE_NAME"
    ;;
  logs)
    exec journalctl --user -u "$SERVICE_NAME" -n 100 --no-pager
    ;;
  *)
    usage
    exit 1
    ;;
esac
