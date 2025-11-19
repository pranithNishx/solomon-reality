# DigitalOcean Deployment Guide (covnantreality.com)

This document walks through every step required to deploy the Solomon Realty project on a DigitalOcean Droplet and serve it at **https://covnantreality.com**.

---

## 1. Create the Droplet

1. Sign in to [DigitalOcean](https://cloud.digitalocean.com/).
2. Click **Create → Droplets**.
3. Choose image: **Ubuntu 22.04 LTS**.
4. Choose a plan: at least **2 vCPU / 4 GB RAM** (match repo notes).
5. Choose datacenter region closest to users (e.g., Bangalore `blr1`).
6. Authentication: add SSH key (recommended) or set a strong password.
7. Hostname: `covnantreality`.
8. Click **Create Droplet** and note the public IP.

Add a floating IP later if desired (optional but recommended).

---

## 2. Initial Server Setup

SSH into the droplet:
```bash
ssh root@YOUR_DROPLET_IP
```

Run OS updates:
```bash
apt update && apt upgrade -y
```

Install core packages:
```bash
apt install -y build-essential git curl ufw
```

---

## 3. Install Node.js 18 + npm + PM2

Remove any old Node installations:
```bash
apt remove -y nodejs
apt autoremove -y
```

Install Node.js 18 from NodeSource (includes npm):
```bash
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt install -y nodejs
node --version   # should be v18.x
npm --version
```

Install PM2 globally:
```bash
npm install -g pm2
pm2 startup systemd -u root --hp /root
```

---

## 4. Prepare Project Directory

```bash
mkdir -p /var/www/solomon-reality
cd /var/www/solomon-reality
git clone https://github.com/YOUR_GITHUB_ACCOUNT/solomon-reality.git .
```

> **Tip:** replace the remote with your private fork if necessary.

---

## 5. Configure Environment Variables

1. Copy the sample file:
   ```bash
   cp env.sample .env
   ```
2. Edit `.env` and fill in all secrets:
   ```bash
   nano .env
   ```
   Required values (at minimum):
   ```
   NODE_ENV=production
   PORT=5000
   DATABASE_URL=/var/www/solomon-reality/backend/database.sqlite
   JWT_SECRET=<generate strong secret>
   IMAGEKIT_PUBLIC_KEY=...
   IMAGEKIT_PRIVATE_KEY=...
   IMAGEKIT_URL_ENDPOINT=https://ik.imagekit.io/your_id
   FRONTEND_URL=https://covnantreality.com
   BACKEND_URL=https://covnantreality.com/api
   NEXT_PUBLIC_API_URL=https://covnantreality.com/api
   NEXT_PUBLIC_IMAGEKIT_ENDPOINT=https://ik.imagekit.io/your_id
   ```

---

## 6. Install Dependencies & Build

From `/var/www/solomon-reality`:
```bash
npm install            # installs root dev tools (pm2, concurrently)
cd backend && npm install --production && cd ..
cd frontend && npm install --production && npm run build && cd ..
```

The `frontend` build generates `.next` output in production mode.

---

## 7. Configure PM2

The repo already includes `ecosystem.config.js`. Start both apps:
```bash
pm2 start ecosystem.config.js --env production
pm2 save
pm2 status
```

This runs:
- Backend API on port **5000**
- Frontend (Next.js) on port **3000**

---

## 8. Configure Nginx + SSL

### 8.1 Install Nginx & Certbot
```bash
apt install -y nginx
snap install core && snap refresh core
snap install --classic certbot
ln -s /snap/bin/certbot /usr/bin/certbot
```

### 8.2 Firewall
```bash
ufw allow OpenSSH
ufw allow 'Nginx Full'
ufw enable
```

### 8.3 Place Nginx config
1. Copy `nginx.conf` from the repo to `/etc/nginx/sites-available/solomon-reality`.
   ```bash
   cp /var/www/solomon-reality/nginx.conf /etc/nginx/sites-available/solomon-reality
   ```
2. Enable the site:
   ```bash
   ln -s /etc/nginx/sites-available/solomon-reality /etc/nginx/sites-enabled/
   nginx -t
   systemctl restart nginx
   ```

### 8.4 Obtain SSL certificate (LetsEncrypt)
Make sure DNS A record points `covnantreality.com` and `www` to the droplet IP.

```bash
certbot --nginx -d covnantreality.com -d www.covnantreality.com
```

Certbot updates the config and reloads Nginx automatically. Certificates renew via cron; test with:
```bash
certbot renew --dry-run
```

---

## 9. Verify Deployment

1. Visit `https://covnantreality.com`.
2. Check PM2:
   ```bash
   pm2 status
   pm2 logs --lines 50
   ```
3. Hit the health endpoint:
   ```bash
   curl -I https://covnantreality.com/health
   ```
4. Verify API:
   ```bash
   curl -I https://covnantreality.com/api/auth/verify
   ```

---

## 10. Automate Deployments (optional but recommended)

1. Add SSH key from GitHub Actions to the droplet (store private key in repo secrets).
2. Use the existing `.github/workflows/deploy.yml` which assumes:
   - Secrets: `HOST`, `USERNAME`, `SSH_KEY`, `PORT`, `DEPLOY_PATH`.
   - The workflow runs `./deploy.sh` on the server after pulling latest code.
3. Ensure `/var/www/solomon-reality/deploy.sh` is executable:
   ```bash
   chmod +x /var/www/solomon-reality/deploy.sh
   ```

---

## 11. Maintenance Checklist

| Task | Command |
|------|---------|
| View logs | `pm2 logs` / `journalctl -u nginx` |
| Restart services | `pm2 restart ecosystem.config.js` / `systemctl restart nginx` |
| Update code | `cd /var/www/solomon-reality && git pull && ./deploy.sh` |
| Database backup | `sudo ./backup.sh` (customize script) |
| Security updates | `apt update && apt upgrade -y` (monthly) |

---

## 12. Troubleshooting Tips

- **502 Bad Gateway**: Check PM2 processes (`pm2 status`) and ensure backend/frontend running.
- **Certbot fails**: Confirm DNS records, stop nginx if port conflict (`systemctl stop nginx`) then re-run.
- **Env errors**: Ensure `.env` exists and `deploy.sh` is run from project root.
- **Port conflicts**: Backend uses 5000, frontend 3000. Adjust in `ecosystem.config.js` & Nginx if needed.
- **Memory issues**: Upgrade droplet or add swap (`fallocate -l 2G /swapfile` …).

---

Deployment complete! Your application should now be live at **https://covnantreality.com**. Keep PM2 and Nginx running, monitor logs, and schedule backups to maintain uptime.

