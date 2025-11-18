#!/bin/bash

# Deployment script for Solomon Realty
# This script is executed on the server after code is pulled from Git

set -e  # Exit on error

echo "🚀 Starting deployment..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

# Check if .env file exists
if [ ! -f .env ]; then
    echo -e "${RED}❌ Error: .env file not found!${NC}"
    echo "Please create a .env file with all required environment variables."
    exit 1
fi

# Load environment variables
export $(cat .env | grep -v '^#' | xargs)

echo -e "${YELLOW}📦 Installing backend dependencies...${NC}"
cd backend
npm ci --production
cd ..

echo -e "${YELLOW}📦 Installing frontend dependencies...${NC}"
cd frontend
npm ci --production
cd ..

echo -e "${YELLOW}🏗️  Building frontend...${NC}"
cd frontend
npm run build
cd ..

echo -e "${YELLOW}🔄 Restarting PM2 processes...${NC}"
pm2 restart ecosystem.config.js --update-env

echo -e "${GREEN}✅ Deployment completed successfully!${NC}"
echo -e "${GREEN}📊 Check status with: pm2 status${NC}"
echo -e "${GREEN}📝 Check logs with: pm2 logs${NC}"

