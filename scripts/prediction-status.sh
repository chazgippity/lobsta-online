#!/usr/bin/env bash
# Extract prediction statuses from blog post frontmatter.
# Single source of truth — no separate state file needed.
# Usage: bash scripts/prediction-status.sh [--pending|--resolved|--json]
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
POSTS_DIR="$ROOT_DIR/posts"
MODE="${1:---all}"

python3 - "$POSTS_DIR" "$MODE" <<'PY'
import json, re, sys
from pathlib import Path

posts_dir = Path(sys.argv[1])
mode = sys.argv[2]

predictions = []

for post_path in sorted(posts_dir.glob("*.md"), reverse=True):
    raw = post_path.read_text(encoding="utf-8")
    lines = raw.splitlines()[:60]  # scan frontmatter + prediction block
    
    status = ""
    status_note = ""
    prediction = ""
    title = ""
    published = ""
    due = ""
    
    for line in lines:
        s = line.strip()
        if s.startswith("# ") and not title:
            title = s[2:].strip()
        elif s.lower().startswith("prediction-status:"):
            raw_ps = s.split(":", 1)[1].strip()
            parts = re.split(r"\s*[—–]\s*|\s+-\s+", raw_ps, maxsplit=1)
            key = parts[0].strip().lower()
            if key.startswith("partial"):
                status = "partial"
            elif key in ("correct", "wrong", "pending"):
                status = key
            else:
                status = "pending"
            status_note = parts[1].strip() if len(parts) > 1 else ""
        elif s.lower().startswith("prediction:") and not prediction:
            prediction = s.split(":", 1)[1].strip()
        elif s.lower().startswith("published:"):
            published = s.split(":", 1)[1].strip()
        elif s.lower().startswith("prediction-due:"):
            due = s.split(":", 1)[1].strip()
    
    if not status:
        continue
    
    predictions.append({
        "file": post_path.name,
        "title": title,
        "prediction": prediction,
        "status": status,
        "note": status_note,
        "published": published,
        "due": due,
    })

if mode == "--json":
    print(json.dumps(predictions, indent=2))
elif mode == "--pending":
    pending = [p for p in predictions if p["status"] == "pending"]
    for p in pending:
        due_str = f" (due: {p['due']})" if p["due"] else ""
        print(f"⏳ {p['prediction'] or p['title']}{due_str}")
        print(f"   └─ {p['file']}")
    if not pending:
        print("No pending predictions.")
elif mode == "--resolved":
    resolved = [p for p in predictions if p["status"] != "pending"]
    for p in resolved:
        emoji = {"correct": "✅", "wrong": "❌", "partial": "🟡"}.get(p["status"], "?")
        note = f" — {p['note']}" if p["note"] else ""
        print(f"{emoji} {p['prediction'] or p['title']}{note}")
        print(f"   └─ {p['file']}")
else:
    correct = len([p for p in predictions if p["status"] == "correct"])
    wrong = len([p for p in predictions if p["status"] == "wrong"])
    partial = len([p for p in predictions if p["status"] == "partial"])
    pending = len([p for p in predictions if p["status"] == "pending"])
    print(f"Predictions: ✅ {correct}  ❌ {wrong}  🟡 {partial}  ⏳ {pending}")
    print()
    for p in predictions:
        emoji = {"correct": "✅", "wrong": "❌", "partial": "🟡", "pending": "⏳"}.get(p["status"], "?")
        note = f" — {p['note']}" if p["note"] else ""
        print(f"{emoji} {p['prediction'] or p['title']}{note}")
PY
