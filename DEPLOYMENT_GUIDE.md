# 🚀 Solomon Realty - Production Deployment Guide

Complete step-by-step guide to deploy Solomon Realty to Digital Ocean Droplet with automatic CI/CD.

---

## 📋 Prerequisites

- Digital Ocean account
- Domain name (optional but recommended)
- GitHub account
- Basic knowledge of Linux commands

---

## 🗂️ Table of Contents

1. [Initial Server Setup](#1-initial-server-setup)
2. [Install Required Software](#2-install-required-software)
3. [Setup Git Repository](#3-setup-git-repository)
4. [Configure Environment Variables](#4-configure-environment-variables)
5. [Setup Database](#5-setup-database)
6. [Install and Configure PM2](#6-install-and-configure-pm2)
7. [Setup Nginx](#7-setup-nginx)
8. [Setup SSL Certificate](#8-setup-ssl-certificate)
9. [Configure GitHub Actions](#9-configure-github-actions)
10. [Final Steps](#10-final-steps)

---

## 1. Initial Server Setup

### 1.1 Create Digital Ocean Droplet

1. Log in to [Digital Ocean](https://www.digitalocean.com/)
2. Click **Create** → **Droplets**
3. Choose:
   - **Image**: Ubuntu 22.04 LTS
   - **Plan**: Basic (at least 2GB RAM, 1 vCPU recommended)
   - **Region**: Choose closest to your users
   - **Authentication**: SSH keys (recommended) or Password
4. Click **Create Droplet**

### 1.2 Connect to Your Server

```bash
ssh root@YOUR_SERVER_IP
```

Or if using a non-root user:
```bash
ssh username@YOUR_SERVER_IP
```

### 1.3 Update System

```bash
apt update && apt upgrade -y
```

### 1.4 Create Deployment User (Optional but Recommended)

```bash
# Create a new user
adduser deploy

# Add user to sudo group
usermod -aG sudo deploy

# Switch to deploy user
su - deploy
```

---

## 2. Install Required Software

### 2.1 Install Node.js (v18 or higher)

```bash
# Install Node.js 18.x
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

# Verify installation
node --version
npm --version
```

### 2.2 Install PM2 (Process Manager)

```bash
sudo npm install -g pm2

# Setup PM2 to start on boot
pm2 startup
# Follow the instructions it provides
```

### 2.3 Install Nginx

```bash
sudo apt install nginx -y

# Start and enable Nginx
sudo systemctl start nginx
sudo systemctl enable nginx
```

### 2.4 Install Git

```bash
sudo apt install git -y
```

### 2.5 Install Certbot (for SSL)

```bash
sudo apt install certbot python3-certbot-nginx -y
```

---

## 3. Setup Git Repository

### 3.1 On Your Local Machine

```bash
# Navigate to your project directory
cd /path/to/solomon-reality

# Initialize Git (if not already done)
git init

# Add all files
git add .

# Create initial commit
git commit -m "Initial commit - Production ready"

# Create repository on GitHub
# Go to https://github.com/new
# Create a new repository (e.g., solomon-reality)

# Add remote and push
git remote add origin https://github.com/YOUR_USERNAME/solomon-reality.git
git branch -M main
git push -u origin main
```

### 3.2 On Your Server

```bash
# Navigate to home directory
cd ~

# Create project directory
mkdir -p /var/www/solomon-reality
cd /var/www/solomon-reality

# Clone your repository
git clone https://github.com/YOUR_USERNAME/solomon-reality.git .

# Or if using SSH:
# git clone git@github.com:YOUR_USERNAME/solomon-reality.git .
```

---

## 4. Configure Environment Variables

### 4.1 Create .env File on Server

```bash
cd /var/www/solomon-reality
nano .env
```

### 4.2 Add Environment Variables

```env
# Server Configuration
NODE_ENV=production
PORT=5000
FRONTEND_PORT=3000

# Database
DATABASE_URL=/var/www/solomon-reality/backend/database.sqlite

# JWT Secret (Generate a strong random string)
JWT_SECRET=your-super-secret-jwt-key-change-this-to-random-string

# ImageKit Configuration
IMAGEKIT_PUBLIC_KEY=your-imagekit-public-key
IMAGEKIT_PRIVATE_KEY=your-imagekit-private-key
IMAGEKIT_URL_ENDPOINT=your-imagekit-url-endpoint

# CORS (Update with your domain)
CORS_ORIGIN=https://your-domain.com

# Frontend URL
NEXT_PUBLIC_API_URL=https://your-domain.com/api
```

**Important**: Generate a strong JWT_SECRET:
```bash
openssl rand -base64 32
```

### 4.3 Create .env File for Frontend (if needed)

```bash
cd /var/www/solomon-reality/frontend
nano .env.local
```

```env
NEXT_PUBLIC_API_URL=https://your-domain.com/api
```

---

## 5. Setup Database

```bash
cd /var/www/solomon-reality

# Create logs directory
mkdir -p logs

# The database will be created automatically on first run
# But you can test the connection:
cd backend
node -e "const {db} = require('./config/database'); console.log('Database connected');"
```

---

## 6. Install and Configure PM2

### 6.1 Install Dependencies

```bash
cd /var/www/solomon-reality

# Install backend dependencies
cd backend
npm install --production
cd ..

# Install frontend dependencies
cd frontend
npm install --production
cd ..
```

### 6.2 Build Frontend

```bash
cd frontend
npm run build
cd ..
```

### 6.3 Start Applications with PM2

```bash
# Start both applications
pm2 start ecosystem.config.js

# Save PM2 configuration
pm2 save

# Check status
pm2 status

# View logs
pm2 logs
```

---

## 7. Setup Nginx

### 7.1 Copy Nginx Configuration

```bash
# Copy the nginx.conf to Nginx sites-available
sudo cp /var/www/solomon-reality/nginx.conf /etc/nginx/sites-available/solomon-reality

# Edit the file to update your domain
sudo nano /etc/nginx/sites-available/solomon-reality
```

**Update these lines:**
- Replace `your-domain.com` with your actual domain
- Update SSL certificate paths (if you have them)

### 7.2 Enable Site

```bash
# Create symlink
sudo ln -s /etc/nginx/sites-available/solomon-reality /etc/nginx/sites-enabled/

# Remove default site (optional)
sudo rm /etc/nginx/sites-enabled/default

# Test Nginx configuration
sudo nginx -t

# Reload Nginx
sudo systemctl reload nginx
```

---

## 8. Setup SSL Certificate

### 8.1 Using Let's Encrypt (Free SSL)

```bash
# Make sure your domain points to your server IP
# Then run:
sudo certbot --nginx -d your-domain.com -d www.your-domain.com

# Follow the prompts
# Certbot will automatically configure Nginx
```

### 8.2 Auto-renewal

Certbot sets up auto-renewal automatically. Test it:
```bash
sudo certbot renew --dry-run
```

---

## 9. Configure GitHub Actions

### 9.1 Add GitHub Secrets

1. Go to your GitHub repository
2. Click **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret**
4. Add these secrets:

   - **HOST**: Your server IP address
   - **USERNAME**: Your server username (e.g., `root` or `deploy`)
   - **SSH_KEY**: Your private SSH key (content of `~/.ssh/id_rsa` on your local machine)
   - **PORT**: SSH port (usually `22`)
   - **DEPLOY_PATH**: `/var/www/solomon-reality`

### 9.2 Generate SSH Key (if needed)

On your local machine:
```bash
# Generate SSH key (if you don't have one)
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"

# Copy public key to server
ssh-copy-id username@YOUR_SERVER_IP

# Copy private key content for GitHub secret
cat ~/.ssh/id_rsa
# Copy the entire output and paste it as SSH_KEY secret
```

### 9.3 Test Deployment

1. Make a small change to your code
2. Commit and push:
   ```bash
   git add .
   git commit -m "Test deployment"
   git push origin main
   ```
3. Check GitHub Actions tab in your repository
4. The deployment should run automatically

---

## 10. Final Steps

### 10.1 Create Admin User

```bash
cd /var/www/solomon-reality/backend
node scripts/createAdmin.js
```

### 10.2 Verify Everything Works

1. **Check PM2 Status**:
   ```bash
   pm2 status
   pm2 logs
   ```

2. **Check Nginx**:
   ```bash
   sudo systemctl status nginx
   ```

3. **Test Your Site**:
   - Visit `https://your-domain.com`
   - Test API: `https://your-domain.com/api/health`

### 10.3 Useful Commands

```bash
# View PM2 logs
pm2 logs

# Restart applications
pm2 restart all

# Stop applications
pm2 stop all

# View Nginx logs
sudo tail -f /var/log/nginx/solomon-reality-error.log

# Check disk space
df -h

# Check memory usage
free -h

# Manual deployment (if needed)
cd /var/www/solomon-reality
git pull
./deploy.sh
```

---

## 🔒 Security Checklist

- [ ] Change default SSH port (optional)
- [ ] Setup firewall (UFW)
- [ ] Use strong passwords/SSH keys
- [ ] Keep system updated
- [ ] Setup regular backups
- [ ] Monitor logs regularly
- [ ] Use strong JWT_SECRET
- [ ] Enable SSL/HTTPS
- [ ] Configure CORS properly

### Setup Firewall

```bash
# Allow SSH
sudo ufw allow 22/tcp

# Allow HTTP and HTTPS
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp

# Enable firewall
sudo ufw enable

# Check status
sudo ufw status
```

---

## 📊 Monitoring

### PM2 Monitoring

```bash
# Install PM2 monitoring (optional)
pm2 install pm2-logrotate
pm2 set pm2-logrotate:max_size 10M
pm2 set pm2-logrotate:retain 7
```

### Setup Backups

Create a backup script:

```bash
#!/bin/bash
# backup.sh
BACKUP_DIR="/var/backups/solomon-reality"
DATE=$(date +%Y%m%d_%H%M%S)

mkdir -p $BACKUP_DIR

# Backup database
cp /var/www/solomon-reality/backend/database.sqlite $BACKUP_DIR/database_$DATE.sqlite

# Keep only last 7 days
find $BACKUP_DIR -name "database_*.sqlite" -mtime +7 -delete
```

Add to crontab:
```bash
crontab -e
# Add: 0 2 * * * /var/www/solomon-reality/backup.sh
```

---

## 🐛 Troubleshooting

### Application not starting
```bash
pm2 logs
# Check for errors
```

### Nginx 502 Bad Gateway
- Check if backend is running: `pm2 status`
- Check backend logs: `pm2 logs solomon-backend`
- Verify port 5000 is accessible

### Frontend not loading
- Check if frontend is running: `pm2 status`
- Check frontend logs: `pm2 logs solomon-frontend`
- Verify build completed: `ls frontend/.next`

### SSL Certificate Issues
```bash
sudo certbot certificates
sudo certbot renew
```

---

## 📞 Support

If you encounter issues:
1. Check PM2 logs: `pm2 logs`
2. Check Nginx logs: `sudo tail -f /var/log/nginx/solomon-reality-error.log`
3. Verify environment variables are set correctly
4. Ensure all ports are open in firewall

---

## ✅ Deployment Complete!

Your Solomon Realty application is now live and will automatically update whenever you push to the main branch!

**Next Steps:**
- Test all features
- Setup monitoring
- Configure backups
- Add custom domain (if not done)
- Setup email notifications (optional)

---

**🎉 Congratulations! Your application is now in production!**

