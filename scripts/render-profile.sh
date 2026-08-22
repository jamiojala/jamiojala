#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source_file="$repo_root/design/profile-page.html"
output_file="$repo_root/assets/profile-page.png"
site_art="$repo_root/../jamiojala/src/assets/archipelago-home.webp"
chrome="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"

if [[ ! -f "$source_file" ]]; then
  echo "Missing profile source: $source_file" >&2
  exit 1
fi

if [[ ! -f "$site_art" ]]; then
  echo "Missing shared personal-site artwork: $site_art" >&2
  exit 1
fi

if [[ ! -x "$chrome" ]]; then
  echo "Google Chrome is required at: $chrome" >&2
  exit 1
fi

"$chrome" \
  --headless=new \
  --hide-scrollbars \
  --allow-file-access-from-files \
  --force-device-scale-factor=1 \
  --window-size=1000,3210 \
  --virtual-time-budget=5000 \
  --screenshot="$output_file" \
  "file://$source_file"

sips -g pixelWidth -g pixelHeight -g format -g space "$output_file"
