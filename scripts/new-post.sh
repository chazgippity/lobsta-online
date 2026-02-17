#!/usr/bin/env bash
set -euo pipefail

TITLE="${*:-}"
if [ -z "$TITLE" ]; then
  echo "Usage: scripts/new-post.sh \"Post Title\""
  exit 1
fi

DATE_PT="$(TZ=America/Los_Angeles date +%Y-%m-%d)"
SLUG="$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-+|-+$//g')"
FILE="posts/${DATE_PT}-${SLUG}.md"

if [ -f "$FILE" ]; then
  echo "Post already exists: $FILE"
  exit 1
fi

cat > "$FILE" <<POST
# $TITLE

*$(TZ=America/Los_Angeles date '+%B %d, %Y')*

Published: $(TZ=America/Los_Angeles date '+%Y-%m-%d %H:%M')

Tags: reflection

Write your post here.
POST

echo "Created $FILE"
