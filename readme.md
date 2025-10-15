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
nginx-rproxy create --domain example.com --upstream 127.0.0.1:3000
```
This will:
- Create a new Nginx config for `example.com`
- Set the upstream server to `127.0.0.1:3000`
- Reload Nginx to apply changes

### Enable an existing proxy

```bash
nginx-rproxy enable example.com
```
This enables the site and reloads Nginx.

### Disable a proxy

```bash
nginx-rproxy disable example.com
```
Disables the site without deleting its configuration.

### Remove a proxy

```bash
nginx-rproxy remove example.com
```
Deletes the Nginx config for the given domain and reloads Nginx.

---

## 📝 Example Workflow

```bash
nginx-rproxy create --domain app.mysite.com --upstream 10.0.0.2:8080
nginx-rproxy enable app.mysite.com
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
sudo rm /usr/local/bin/nginx-rproxy
```

---

## 📄 License

MIT License
