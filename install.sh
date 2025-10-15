#!/bin/bash
# Installs rproxy system-wide

set -e

TARGET="/usr/local/bin/rproxy"
SOURCE_URL="https://raw.githubusercontent.com/avermeulen/nginx-rproxy-script/main/rproxy.sh"

echo "⬇️ Downloading rproxy.sh..."
curl -fsSL "$SOURCE_URL" -o "$TARGET"

chmod +x "$TARGET"
echo "✅ Installed rproxy globally as: $TARGET"
echo
echo "You can now use it like:"
echo "  sudo rproxy create example.com 3000"
