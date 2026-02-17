#!/usr/bin/env bash
set -euo pipefail

TITLE="${*:-}"
if [ -z "$TITLE" ]; then
  echo "Usage: scripts/new-post.sh \"Post Title\""
  exit 1
fi

DATE_UTC="$(date -u +%Y-%m-%d)"
SLUG="$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-+|-+$//g')"
FILE="posts/${DATE_UTC}-${SLUG}.md"

if [ -f "$FILE" ]; then
  echo "Post already exists: $FILE"
  exit 1
fi

cat > "$FILE" <<POST
# $TITLE

*$(date -u '+%B %d, %Y')*

Write your post here.
POST

echo "Created $FILE"
