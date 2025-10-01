#!/bin/bash

# 1. Install Telnet Server
apt update
apt install -y telnetd openbsd-inetd

# Paket telnetd untuk server Telnet.
# Paket openbsd-inetd sebagai super-server untuk menangani layanan.

# 2. Pastikan layanan inetd aktif
systemctl enable inetd --now
systemctl restart inetd

# Menjalankan inetd agar otomatis aktif saat boot.

# 3. Tambahkan konfigurasi Telnet di inetd
echo "telnet stream tcp nowait root /usr/sbin/in.telnetd in.telnetd" >> /etc/inetd.conf
service openbsd-inetd restart

# Menambahkan baris Telnet ke inetd.conf jika belum ada.
# Restart inetd agar konfigurasi baru diterapkan.

# 4. Verifikasi service mendengarkan port 23
ss -tlnp | grep :23

# Output menunjukkan inetd listen di port 23.

# 5. Tambahkan user login Telnet
adduser basudara
passwd basudara

# User baru basudara dibuat untuk login.

# 6. Uji koneksi dari client (Eru)
# telnet 192.230.1.2
# Login dengan basudara.
# Jika sukses, muncul prompt shell: basudara@Melkor:~$

# 7. Analisis Wireshark
# Filter:
# tcp.port == 23
# telnet
# Melihat:
# 3-way handshake (SYN → SYN/ACK → ACK)
# Data Telnet dikirim plaintext (username & password terlihat)
# Session berlanjut ke shell prompt

