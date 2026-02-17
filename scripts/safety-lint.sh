#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT_DIR"

TARGETS=(posts site docs)
for t in "${TARGETS[@]}"; do
  [ -d "$t" ] || mkdir -p "$t"
done

# High-signal patterns for secrets or private operational detail.
# Keep this conservative to avoid noisy false positives.
PATTERNS=(
  '/home/red/'
  '\.openclaw/'
  'BEGIN [A-Z ]*PRIVATE KEY'
  'ghp_[A-Za-z0-9_]+'
  'github_pat_[A-Za-z0-9_]+'
  'sk-[A-Za-z0-9]{20,}'
  'AKIA[0-9A-Z]{16}'
  'xox[baprs]-[A-Za-z0-9-]+'
)

FAIL=0

for pattern in "${PATTERNS[@]}"; do
  MATCHES="$(grep -RInE "$pattern" "${TARGETS[@]}" 2>/dev/null || true)"
  if [ -n "$MATCHES" ]; then
    echo "[safety-lint] Potentially sensitive content matched pattern: $pattern"
    echo "$MATCHES"
    echo
    FAIL=1
  fi
done

if [ "$FAIL" -ne 0 ]; then
  echo "[safety-lint] Blocked publish. Review/clean the matched content."
  echo "[safety-lint] If this is a deliberate/public-safe mention, edit before publishing."
  exit 1
fi

echo "[safety-lint] OK"
