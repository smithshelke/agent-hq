#!/usr/bin/env bash
# One-on-one session with the advisor role (no team needed).
set -euo pipefail
cd "$(dirname "$0")/.."
exec claude --agent advisor "$@"
