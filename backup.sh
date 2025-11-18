#!/bin/bash

# Backup script for Solomon Realty
# Run this daily via cron: 0 2 * * * /var/www/solomon-reality/backup.sh

set -e

# Configuration
BACKUP_DIR="/var/backups/solomon-reality"
DATE=$(date +%Y%m%d_%H%M%S)
RETENTION_DAYS=7

# Create backup directory if it doesn't exist
mkdir -p $BACKUP_DIR

echo "🔄 Starting backup at $(date)"

# Backup database
if [ -f "/var/www/solomon-reality/backend/database.sqlite" ]; then
    cp /var/www/solomon-reality/backend/database.sqlite "$BACKUP_DIR/database_$DATE.sqlite"
    echo "✅ Database backed up: database_$DATE.sqlite"
else
    echo "⚠️  Database file not found, skipping..."
fi

# Backup environment file (optional - contains sensitive data)
# Uncomment if you want to backup .env (ensure backups are secure!)
# cp /var/www/solomon-reality/.env "$BACKUP_DIR/env_$DATE.env"

# Compress old backups (optional)
# gzip "$BACKUP_DIR/database_$DATE.sqlite"

# Remove backups older than retention period
find $BACKUP_DIR -name "database_*.sqlite" -mtime +$RETENTION_DAYS -delete
echo "🗑️  Removed backups older than $RETENTION_DAYS days"

# List current backups
echo "📦 Current backups:"
ls -lh $BACKUP_DIR | tail -n +2

echo "✅ Backup completed at $(date)"

