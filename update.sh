#!/bin/bash
# Updates rproxy to the latest version from GitHub

set -e

TARGET="/usr/local/bin/rproxy"
SOURCE_URL="https://raw.githubusercontent.com/avermeulen/nginx-rproxy-script/main/rproxy.sh"

echo "⬇️ Downloading latest rproxy.sh..."
curl -fsSL "$SOURCE_URL" -o "$TARGET"

chmod +x "$TARGET"
echo "✅ Successfully updated rproxy at: $TARGET"
echo
echo "You can verify the installation with:"
echo "  sudo rproxy list"
