#!/bin/bash
# soal_7.sh

# Tambah user ainur & folder shared
adduser ainur
passwd ainur
mkdir -p /home/ainur/shared
chown ainur:ainur /home/ainur/shared
chmod 755 /home/ainur /home/ainur/shared

# Konfigurasi vsftpd agar user diarahkan ke folder shared
mkdir -p /etc/vsftpd_user_conf
echo "local_root=/home/ainur/shared" > /etc/vsftpd_user_conf/ainur

#update 
apt-get update
apt-get install -y vsftpd


# Pastikan vsftpd.conf ada baris:
nano /etc/vsftpd.conf

local_enable=YES
write_enable=YES
chroot_local_user=YES
allow_writeable_chroot=YES
user_sub_token=$USER
local_root=/home/$USER/shared
user_config_dir=/etc/vsftpd_user_conf

service vsftpd restart

# Test file upload untuk user ainur
echo "Halo dari ainur" > /home/ainur/shared/test.txt
ftp localhost <<EOF
user ainur [password_ainur]
ls
put test.txt
bye
EOF

# Tambah user melkor & set password
adduser melkor
passwd melkor
chmod 750 /home/ainur/shared

# Test login melkor (tidak bisa tulis ke shared)
ftp localhost <<EOF
user melkor [password_melkor]
cd shared   # Harusnya gagal: 550 Failed to change directory
bye
EOF

# Hasil yang diharapkan:
# - ainur bisa upload/download ke /home/ainur/shared
# - melkor login sukses tapi tidak bisa akses folder shared

