# 🐘 Odoo Docker Database Backup Tool

Script Bash sederhana untuk melakukan **backup database PostgreSQL** dan **filestore Odoo** yang berjalan di dalam container Docker.  
Mendukung format backup **SQL** maupun **Custom Dump** (`.dump`).

---

## ✨ Fitur
- ✅ Backup database PostgreSQL dari container Odoo/Postgres
- ✅ Backup filestore Odoo
- ✅ Pilihan format output **.sql** atau **.dump**
- ✅ Timestamp otomatis pada nama file backup
- ✅ Output disimpan ke direktori lokal

---

## 📂 Struktur Backup
- **Database** → `nama_database_db_YYYYMMDD_HHMMSS.sql` atau `.dump`  
- **Filestore** → `nama_database_filestore_YYYYMMDD_HHMMSS.tar.gz`

---

## ⚙️ Cara Pakai

### 1. Pastikan file script bisa dieksekusi
```bash
chmod +x backup_odoo.sh 
```

### 2. Jalankan script
```bash
./backup_odoo.sh
```

### 3. Pilih format backup
Saat dijalankan, script akan meminta input:
```bash
Pilih format backup (sql/dump):
```
- Ketik sql → hasil backup berupa file .sql
- Ketik dump → hasil backup berupa file .dump

## Screenshot
![](https://github.com/arifnrrmdn/odoo-docker-database-backup-tool/blob/main/screenshoot/1.png)
