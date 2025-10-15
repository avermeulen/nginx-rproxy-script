#!/bin/bash
# Simple Nginx reverse proxy manager
# Usage:
#   sudo rproxy create <domain> <port>
#   sudo rproxy link <domain>
#   sudo rproxy unlink <domain>
#
# Example:
#   sudo rproxy create example.com 3000
#   sudo rproxy link example.com
#   sudo rproxy unlink example.com

set -e

SITES_AVAILABLE="/etc/nginx/sites-available"
SITES_ENABLED="/etc/nginx/sites-enabled"

if [[ $EUID -ne 0 ]]; then
   echo "Please run as root (use sudo)."
   exit 1
fi

ACTION=$1
DOMAIN=$2
PORT=$3

create_site() {
    if [[ -z "$DOMAIN" || -z "$PORT" ]]; then
        echo "Usage: sudo $0 create <domain> <port>"
        exit 1
    fi

    CONFIG_PATH="$SITES_AVAILABLE/$DOMAIN.conf"

    if [[ -f "$CONFIG_PATH" ]]; then
        echo "⚠️ Config already exists: $CONFIG_PATH"
    else
        echo "📝 Creating config for $DOMAIN..."
        cat > "$CONFIG_PATH" <<EOF
server {
    listen 80;
    server_name $DOMAIN;

    location / {
        proxy_pass http://127.0.0.1:$PORT;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOF
        echo "✅ Created $CONFIG_PATH"
    fi

    link_site
}

link_site() {
    CONFIG_PATH="$SITES_AVAILABLE/$DOMAIN.conf"
    LINK_PATH="$SITES_ENABLED/$DOMAIN.conf"

    if [[ ! -f "$CONFIG_PATH" ]]; then
        echo "❌ Config not found: $CONFIG_PATH"
        exit 1
    fi

    ln -sf "$CONFIG_PATH" "$LINK_PATH"
    echo "🔗 Linked $DOMAIN to sites-enabled"
    reload_nginx
}

unlink_site() {
    LINK_PATH="$SITES_ENABLED/$DOMAIN.conf"

    if [[ -L "$LINK_PATH" ]]; then
        rm "$LINK_PATH"
        echo "🚫 Unlinked $DOMAIN (site disabled)"
        reload_nginx
    else
        echo "⚠️ No symlink found for $DOMAIN in sites-enabled"
    fi
}

reload_nginx() {
    echo "🔍 Testing Nginx configuration..."
    nginx -t
    echo "🔄 Reloading Nginx..."
    systemctl reload nginx
    echo "✅ Nginx reloaded successfully."
}

case "$ACTION" in
  create) create_site ;;
  link)
    [[ -z "$DOMAIN" ]] && echo "Usage: sudo $0 link <domain>" && exit 1
    link_site ;;
  unlink)
    [[ -z "$DOMAIN" ]] && echo "Usage: sudo $0 unlink <domain>" && exit 1
    unlink_site ;;
  *)
    echo "Usage:"
    echo "  sudo $0 create <domain> <port>"
    echo "  sudo $0 link <domain>"
    echo "  sudo $0 unlink <domain>"
    exit 1 ;;
esac
