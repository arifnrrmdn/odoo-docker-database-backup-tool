#!/bin/bash

# === KONFIGURASI ===
WEB_CONTAINER="cda0c45af170" # nama container Odoo
DB_CONTAINER="c57ac134e7a3"  # nama container PostgreSQL
DB_USER="odoo"                                   # user database Odoo
DB_NAME="TESTING"                       # nama database Odoo
BACKUP_DIR="/home/ariev/backup"                  # folder backup lokal

# === TANGGAL BACKUP ===
DATE=$(date +"%Y%m%d_%H%M%S")

# === INPUT FORMAT DARI USER ===
echo "Pilih format backup (sql/dump): "
read FORMAT

if [[ "$FORMAT" != "sql" && "$FORMAT" != "dump" ]]; then
    echo "❌ Format tidak valid! Gunakan: sql atau dump"
    exit 1
fi

# === FILE OUTPUT ===
if [[ "$FORMAT" == "sql" ]]; then
    DB_BACKUP="$BACKUP_DIR/${DB_NAME}_db_$DATE.sql"
else
    DB_BACKUP="$BACKUP_DIR/${DB_NAME}_db_$DATE.dump"
fi
FILESTORE_BACKUP="$BACKUP_DIR/${DB_NAME}_filestore_$DATE.tar.gz"

# === INFORMASI BACKUP ===
echo "======================================"
echo "   🚀 INFORMASI BACKUP ODOO DOCKER"
echo "--------------------------------------"
echo " Database Name   : $DB_NAME"
echo " Database User   : $DB_USER"
echo " DB Container    : $DB_CONTAINER"
echo " Web Container   : $WEB_CONTAINER"
echo " Format Output   : $FORMAT"
echo " Lokasi Backup   : $BACKUP_DIR"
echo " File Database   : $DB_BACKUP"
echo " File Filestore  : $FILESTORE_BACKUP"
echo "======================================"
echo

# === KONFIRMASI ===
read -p "Lanjutkan proses backup? (y/n): " CONFIRM
if [[ "$CONFIRM" != "y" && "$CONFIRM" != "Y" ]]; then
    echo "❌ Backup dibatalkan."
    exit 0
fi

# === 1. BACKUP DATABASE ===
echo "📦 Backup database $DB_NAME dalam format $FORMAT..."
if [[ "$FORMAT" == "sql" ]]; then
    docker exec -t $DB_CONTAINER pg_dump -U $DB_USER $DB_NAME > $DB_BACKUP
else
    docker exec -t $DB_CONTAINER pg_dump -U $DB_USER -F c $DB_NAME > $DB_BACKUP
fi

# === 2. BACKUP FILESTORE ===
echo "📂 Backup filestore..."
docker exec -t $WEB_CONTAINER tar -czf - /var/lib/odoo/.local/share/Odoo/filestore/$DB_NAME > $FILESTORE_BACKUP

# === 3. HASIL ===
echo "✅ Backup selesai!"
echo "Database : $DB_BACKUP"
echo "Filestore: $FILESTORE_BACKUP"
