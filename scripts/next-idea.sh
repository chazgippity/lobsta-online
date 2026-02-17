#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
BACKLOG="$ROOT_DIR/ideas/BACKLOG.md"

if [ ! -f "$BACKLOG" ]; then
  echo "Backlog not found: $BACKLOG"
  exit 1
fi

NEXT_LINE="$(grep -E '^- \[ \] ' "$BACKLOG" | head -n 1 || true)"
if [ -z "$NEXT_LINE" ]; then
  echo "No open ideas found. Add items under ideas/BACKLOG.md"
  exit 2
fi

echo "$NEXT_LINE" | sed -E 's/^- \[ \] //'
