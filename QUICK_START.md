# 🚀 Quick Start Guide - Production Deployment

## Prerequisites Checklist

- [ ] Digital Ocean Droplet created (Ubuntu 22.04)
- [ ] Domain name pointed to server IP (optional)
- [ ] GitHub repository created
- [ ] SSH access to server configured

---

## ⚡ Quick Deployment (5 Steps)

### Step 1: Initial Server Setup

```bash
# Connect to your server
ssh root@YOUR_SERVER_IP

# Update system
apt update && apt upgrade -y

# Install Node.js 18
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
apt-get install -y nodejs

# Install PM2, Nginx, Git
npm install -g pm2
apt install nginx git certbot python3-certbot-nginx -y
```

### Step 2: Clone Repository

```bash
# Create project directory
mkdir -p /var/www/solomon-reality
cd /var/www/solomon-reality

# Clone your repo
git clone https://github.com/YOUR_USERNAME/solomon-reality.git .

# Make deploy script executable
chmod +x deploy.sh
```

### Step 3: Setup Environment

```bash
# Create .env file
nano .env
```

Paste and update:
```env
NODE_ENV=production
PORT=5000
FRONTEND_PORT=3000
DATABASE_URL=/var/www/solomon-reality/backend/database.sqlite
JWT_SECRET=$(openssl rand -base64 32)
IMAGEKIT_PUBLIC_KEY=your-key
IMAGEKIT_PRIVATE_KEY=your-key
IMAGEKIT_URL_ENDPOINT=your-endpoint
CORS_ORIGIN=https://your-domain.com
NEXT_PUBLIC_API_URL=https://your-domain.com/api
```

### Step 4: Deploy

```bash
# Run deployment script
./deploy.sh
```

### Step 5: Setup Nginx & SSL

```bash
# Copy and configure Nginx
sudo cp nginx.conf /etc/nginx/sites-available/solomon-reality
sudo nano /etc/nginx/sites-available/solomon-reality
# Update: Replace your-domain.com with your actual domain

# Enable site
sudo ln -s /etc/nginx/sites-available/solomon-reality /etc/nginx/sites-enabled/
sudo rm /etc/nginx/sites-enabled/default
sudo nginx -t
sudo systemctl reload nginx

# Setup SSL
sudo certbot --nginx -d your-domain.com -d www.your-domain.com
```

---

## 🔄 Setup Auto-Deployment (GitHub Actions)

1. **Add GitHub Secrets**:
   - Go to: Repository → Settings → Secrets and variables → Actions
   - Add:
     - `HOST`: Your server IP
     - `USERNAME`: `root` (or your user)
     - `SSH_KEY`: Your private SSH key (`cat ~/.ssh/id_rsa`)
     - `PORT`: `22`
     - `DEPLOY_PATH`: `/var/www/solomon-reality`

2. **Test Deployment**:
   ```bash
   git add .
   git commit -m "Setup production"
   git push origin main
   ```

3. **Check GitHub Actions**: Your code will auto-deploy!

---

## ✅ Verify Deployment

```bash
# Check PM2
pm2 status
pm2 logs

# Check Nginx
sudo systemctl status nginx

# Test API
curl http://localhost:5000/api/health
```

Visit: `https://your-domain.com`

---

## 📝 Important Notes

- **Database**: Located at `/var/www/solomon-reality/backend/database.sqlite`
- **Logs**: Check with `pm2 logs`
- **Restart**: `pm2 restart all`
- **Manual Deploy**: `cd /var/www/solomon-reality && git pull && ./deploy.sh`

---

For detailed instructions, see [DEPLOYMENT_GUIDE.md](./DEPLOYMENT_GUIDE.md)

