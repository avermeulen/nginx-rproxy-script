# 🌀 nginx-rproxy-script

A tiny helper script to quickly **create, enable, disable** Nginx reverse proxies on Linux.

---

## ⚙️ Installation

Install directly from GitHub:

```bash
curl -fsSL https://raw.githubusercontent.com/avermeulen/nginx-rproxy-script/main/install.sh | sudo bash
```

---

## 🚀 Usage

### Create a new reverse proxy

```bash
sudo rproxy create example.com 3000
```
This will:
- Create a new Nginx config for `example.com`
- Set the upstream server to `127.0.0.1:3000`
- Link the site to sites-enabled
- Reload Nginx to apply changes

### Link an existing proxy

```bash
sudo rproxy link example.com
```
This enables the site by creating a symlink in sites-enabled and reloads Nginx.

### Unlink a proxy

```bash
sudo rproxy unlink example.com
```
Disables the site by removing the symlink from sites-enabled without deleting its configuration.

### List all available sites

```bash
sudo rproxy list
```
Lists all sites configured in `/etc/nginx/sites-available/`.

---

## 📝 Example Workflow

```bash
sudo rproxy create app.mysite.com 8080
sudo rproxy list
sudo rproxy unlink app.mysite.com
sudo rproxy link app.mysite.com
```

---

## 🔄 Updating

To update rproxy to the latest version:

```bash
curl -fsSL https://raw.githubusercontent.com/avermeulen/nginx-rproxy-script/main/update.sh | sudo bash
```

This will:
- Download the latest `rproxy.sh` from GitHub
- Replace your existing installation at `/usr/local/bin/rproxy`
- Make the script executable
- Display a success message

After updating, verify the installation with:
```bash
sudo rproxy list
```

---

## 🔧 Configuration

- All configs are stored in `/etc/nginx/sites-available/`
- Enabled sites appear in `/etc/nginx/sites-enabled/`
- Script requires `sudo` privileges to manage Nginx configs and reload service

---

## 🩺 Troubleshooting

- Ensure Nginx is installed and running: `sudo systemctl status nginx`
- Check script permissions if you see errors.
- After changes, verify your config with: `sudo nginx -t`
- View Nginx error log: `sudo tail -f /var/log/nginx/error.log`

---

## 📦 Uninstall

To remove the script:
```bash
sudo rm /usr/local/bin/rproxy
```

---

## 📄 License

MIT License
