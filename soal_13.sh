#!/bin/bash

# 1. Pastikan SSH server (sshd) terinstall dan berjalan di Eru
which sshd >/dev/null 2>&1 || apt update && apt install -y openssh-server

# Mulai sshd jika belum berjalan
ps aux | grep [s]shd >/dev/null 2>&1 || /usr/sbin/sshd

# 2. Cek port 22 listening
netstat -tlnp | grep :22 || ss -tlnp | grep :22

# 3. Ubah password root (opsional)
echo "Ubah password root jika perlu:"
passwd root

# 4. Konfigurasi sshd agar root login & password auth diizinkan
# Edit file /etc/ssh/sshd_config:
#   PermitRootLogin yes
#   PasswordAuthentication yes
#   UsePAM yes
nano /etc/ssh/sshd_config

# Restart sshd setelah konfigurasi
pkill sshd
/usr/sbin/sshd &

# 5. Dari client (Varda/Eru lain), tes koneksi SSH ke Eru
# Contoh:
# ssh root@192.230.1.1
# Login menggunakan password root
# Jika berhasil, terminal akan muncul prompt root@Eru

