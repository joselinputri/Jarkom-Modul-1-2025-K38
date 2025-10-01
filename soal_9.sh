#!/bin/bash
#Command di Server (Eru)
# Download kitab dari Google Drive
wget --no-check-certificate "https://drive.google.com/uc?export=download&id=11ua2KgBu3MnHEIjhBnzqqv2RMEiJsILY" -O kitab_penciptaan.zip

# Pindahkan ke home user ainur & ubah permission
mv kitab_penciptaan.zip /home/ainur/
chown ainur:ainur /home/ainur/kitab_penciptaan.zip
chmod 444 /home/ainur/kitab_penciptaan.zip

# Pastikan vsftpd aktif & konfigurasi
nano /etc/vsftpd.conf
# setting: local_enable=YES, write_enable=NO, chroot_local_user=YES
service vsftpd restart

Command di Client (Manwe)
# Login FTP sebagai ainur
lftp -u ainur,ainur 192.230.1.1

# Lihat file
ls

# Download file (read-only)
get kitab_penciptaan.zip

# Coba upload (should fail)
echo "tes upload" > coba.txt
put coba.txt  # → 550 Permission denied

# Coba hapus file (should fail)
rm kitab_penciptaan.zip  # → 550 Permission denied

# Keluar
bye
d
