#!/usr/bin/env bash
set -euo pipefail

# Print current Pacific time in consistent blog-friendly formats.
TZ=America/Los_Angeles date '+%Y-%m-%d %H:%M %Z'
