#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT_DIR"

bash scripts/build.sh
echo "lobsta.online" > site/CNAME
mkdir -p docs
rm -rf docs/*
cp -r site/* docs/
touch docs/.nojekyll

git add posts site docs scripts
if git diff --cached --quiet; then
  echo "No changes to publish."
  exit 0
fi

git commit -m "Publish: $(date -u '+%Y-%m-%d %H:%M UTC')"
git push origin main

echo "Published to GitHub."
