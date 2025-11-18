# ✅ Production Deployment Checklist

Use this checklist to ensure everything is properly configured for production.

## 📋 Pre-Deployment Checklist

### Code Preparation
- [ ] All environment variables documented in `.env.example`
- [ ] `.env` files are in `.gitignore`
- [ ] No hardcoded secrets or API keys
- [ ] Database migrations ready (if applicable)
- [ ] All dependencies are production-ready
- [ ] Error handling implemented
- [ ] Logging configured

### Security
- [ ] Strong JWT_SECRET generated
- [ ] CORS configured correctly
- [ ] Rate limiting enabled
- [ ] Helmet security headers configured
- [ ] Input validation on all endpoints
- [ ] SQL injection protection (using parameterized queries)
- [ ] XSS protection enabled

### Performance
- [ ] Frontend optimized (Next.js build)
- [ ] Images optimized (ImageKit configured)
- [ ] Gzip compression enabled
- [ ] Caching headers configured
- [ ] Database indexes created
- [ ] PM2 configured for process management

## 🖥️ Server Setup Checklist

### Initial Setup
- [ ] Digital Ocean Droplet created
- [ ] Ubuntu 22.04 LTS installed
- [ ] System updated (`apt update && apt upgrade`)
- [ ] Firewall configured (UFW)
- [ ] SSH key authentication setup
- [ ] Non-root user created (optional but recommended)

### Software Installation
- [ ] Node.js 18+ installed
- [ ] npm 9+ installed
- [ ] PM2 installed globally
- [ ] Nginx installed and running
- [ ] Git installed
- [ ] Certbot installed (for SSL)

### Repository Setup
- [ ] GitHub repository created
- [ ] Code pushed to GitHub
- [ ] Repository cloned on server
- [ ] `.env` file created on server
- [ ] All environment variables configured

### Application Setup
- [ ] Dependencies installed (`npm ci --production`)
- [ ] Frontend built (`npm run build`)
- [ ] Database initialized
- [ ] PM2 processes started
- [ ] PM2 startup script configured

### Web Server Setup
- [ ] Nginx configuration file created
- [ ] Domain name configured
- [ ] SSL certificate installed
- [ ] Nginx configuration tested
- [ ] Nginx reloaded

### CI/CD Setup
- [ ] GitHub Actions workflow file exists
- [ ] GitHub Secrets configured:
  - [ ] HOST
  - [ ] USERNAME
  - [ ] SSH_KEY
  - [ ] PORT
  - [ ] DEPLOY_PATH
- [ ] Auto-deployment tested

## 🔍 Post-Deployment Verification

### Functionality Tests
- [ ] Homepage loads correctly
- [ ] Property listings display
- [ ] Property details page works
- [ ] Search and filters work
- [ ] User registration works
- [ ] User login works
- [ ] Admin dashboard accessible
- [ ] File uploads work (images/videos)
- [ ] API endpoints respond correctly

### Performance Tests
- [ ] Page load times acceptable (< 3s)
- [ ] Images load and optimize correctly
- [ ] No console errors
- [ ] Mobile responsiveness verified
- [ ] API response times acceptable

### Security Tests
- [ ] HTTPS redirects work
- [ ] SSL certificate valid
- [ ] Security headers present
- [ ] CORS configured correctly
- [ ] Rate limiting working
- [ ] Authentication required for protected routes

### Monitoring Setup
- [ ] PM2 monitoring configured
- [ ] Log rotation setup
- [ ] Error logging working
- [ ] Backup strategy implemented

## 📊 Monitoring & Maintenance

### Regular Tasks
- [ ] Monitor PM2 logs weekly
- [ ] Check disk space monthly
- [ ] Review error logs
- [ ] Update dependencies quarterly
- [ ] Backup database regularly
- [ ] Monitor SSL certificate expiration

### Alerts to Setup (Optional)
- [ ] Server downtime alerts
- [ ] High CPU/memory usage alerts
- [ ] Disk space alerts
- [ ] SSL certificate expiration alerts

## 🚨 Emergency Procedures

### If Application Crashes
```bash
pm2 logs
pm2 restart all
```

### If Server Runs Out of Space
```bash
df -h
# Clean old logs
pm2 flush
# Clean npm cache
npm cache clean --force
```

### If Database Corrupts
```bash
# Restore from backup
cp /var/backups/solomon-reality/database_backup.sqlite /var/www/solomon-reality/backend/database.sqlite
pm2 restart solomon-backend
```

### Rollback Deployment
```bash
cd /var/www/solomon-reality
git log  # Find previous commit
git checkout <previous-commit-hash>
./deploy.sh
```

## 📝 Important Files & Locations

- **Application**: `/var/www/solomon-reality`
- **Database**: `/var/www/solomon-reality/backend/database.sqlite`
- **Logs**: `/var/www/solomon-reality/logs/`
- **Nginx Config**: `/etc/nginx/sites-available/solomon-reality`
- **Nginx Logs**: `/var/log/nginx/solomon-reality-*.log`
- **PM2 Config**: `/var/www/solomon-reality/ecosystem.config.js`
- **Environment**: `/var/www/solomon-reality/.env`

## 🔗 Useful Commands Reference

```bash
# PM2
pm2 status
pm2 logs
pm2 restart all
pm2 stop all
pm2 delete all

# Nginx
sudo nginx -t
sudo systemctl reload nginx
sudo systemctl status nginx

# Git
git pull origin main
git log --oneline

# System
df -h  # Disk space
free -h  # Memory
top  # CPU/Memory usage
```

---

**✅ Once all items are checked, your application is production-ready!**

