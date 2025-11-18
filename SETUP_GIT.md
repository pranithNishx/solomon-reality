# 📦 Git Repository Setup Guide

## Step 1: Initialize Git Repository (If Not Already Done)

```bash
# Navigate to your project directory
cd /path/to/solomon-reality

# Initialize Git
git init

# Add all files
git add .

# Create initial commit
git commit -m "Initial commit - Production ready code"
```

## Step 2: Create GitHub Repository

1. Go to [GitHub](https://github.com)
2. Click the **+** icon → **New repository**
3. Repository name: `solomon-reality` (or your preferred name)
4. Description: "Solomon Realty - Luxury Real Estate Platform"
5. Choose **Public** or **Private**
6. **DO NOT** initialize with README, .gitignore, or license (we already have these)
7. Click **Create repository**

## Step 3: Connect Local Repository to GitHub

```bash
# Add remote repository
git remote add origin https://github.com/YOUR_USERNAME/solomon-reality.git

# Or if using SSH:
# git remote add origin git@github.com:YOUR_USERNAME/solomon-reality.git

# Rename branch to main (if needed)
git branch -M main

# Push to GitHub
git push -u origin main
```

## Step 4: Verify Setup

1. Go to your GitHub repository
2. You should see all your files
3. Check that `.env` files are NOT visible (they're in .gitignore)

## Step 5: Setup GitHub Actions Secrets

1. Go to your repository on GitHub
2. Click **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret**
4. Add each secret:

### Required Secrets:

**HOST**
- Name: `HOST`
- Value: Your Digital Ocean droplet IP address
- Example: `123.456.789.0`

**USERNAME**
- Name: `USERNAME`
- Value: Your server username
- Example: `root` or `deploy`

**SSH_KEY**
- Name: `SSH_KEY`
- Value: Your private SSH key
- To get it:
  ```bash
  # On your local machine
  cat ~/.ssh/id_rsa
  # Copy the entire output (including -----BEGIN and -----END lines)
  ```

**PORT**
- Name: `PORT`
- Value: SSH port (usually `22`)

**DEPLOY_PATH**
- Name: `DEPLOY_PATH`
- Value: `/var/www/solomon-reality`

## Step 6: Test Auto-Deployment

1. Make a small change to any file
2. Commit and push:
   ```bash
   git add .
   git commit -m "Test auto-deployment"
   git push origin main
   ```
3. Go to **Actions** tab in GitHub
4. You should see a workflow running
5. Once complete, check your live site - changes should be reflected!

## 🔄 Daily Workflow

After initial setup, your workflow is simple:

```bash
# 1. Make changes to your code
# 2. Commit changes
git add .
git commit -m "Description of changes"

# 3. Push to GitHub
git push origin main

# 4. GitHub Actions automatically deploys to your server!
# Check Actions tab to see deployment progress
```

## 🔐 SSH Key Setup (If Needed)

If you don't have SSH keys:

```bash
# Generate SSH key
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"

# Press Enter to accept default location
# Set a passphrase (optional but recommended)

# Copy public key to server
ssh-copy-id username@YOUR_SERVER_IP

# Test connection
ssh username@YOUR_SERVER_IP
```

## 📋 Git Best Practices

1. **Always commit before pushing**
2. **Write clear commit messages**
3. **Don't commit sensitive data** (.env files are already ignored)
4. **Use branches for features** (optional but recommended)
5. **Test locally before pushing**

## 🐛 Troubleshooting

### "Permission denied" when pushing
- Check your GitHub credentials
- Use SSH instead of HTTPS
- Or use Personal Access Token

### GitHub Actions not running
- Check that workflow file exists: `.github/workflows/deploy.yml`
- Verify all secrets are set correctly
- Check Actions tab for error messages

### Deployment fails
- Check server logs: `pm2 logs`
- Verify SSH key is correct
- Check deploy path exists on server
- Ensure deploy.sh is executable: `chmod +x deploy.sh`

---

**✅ Once setup is complete, every push to main branch will automatically deploy to your live server!**

