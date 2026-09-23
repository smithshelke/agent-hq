#!/usr/bin/env bash
# Start the agent HQ: opens (or reattaches to) a tmux session for this project and starts Claude in it.
# Teammates open as panes in this window. Without tmux, teammates run inside one Claude window instead
# (switch between them with the arrow keys).
set -euo pipefail
cd "$(dirname "$0")/.."
if ! command -v claude >/dev/null 2>&1; then
  echo "Claude Code isn't installed. See https://code.claude.com/docs" >&2; exit 1
fi
if ! command -v tmux >/dev/null 2>&1; then
  echo "tmux not found — running teammates in-process. Install tmux for split panes (macOS: brew install tmux)." >&2
  exec claude --teammate-mode in-process "$@"
fi
# tmux rewrites '.' and ':' in session names, and '.'/':' in a -t target mean window/pane.
name="$(basename "$PWD" | tr '.:' '__')"
if ! tmux has-session -t "=$name" 2>/dev/null; then
  tmux new-session -d -s "$name" -c "$PWD" claude "$@"
fi
if [ -n "${TMUX:-}" ]; then
  exec tmux switch-client -t "=$name"
fi
exec tmux attach-session -t "=$name"
