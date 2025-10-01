
# Di Melkor: Update & install Apache + vsftpd
apt update
apt install -y apache2 vsftpd

# Start services (gunakan systemctl jika ada, service jika tidak)
which systemctl >/dev/null 2>&1 && systemctl enable --now apache2 || service apache2 start
which systemctl >/dev/null 2>&1 && systemctl enable --now vsftpd || service vsftpd start

# Verifikasi port listening 21 dan 80
ss -tlnp | egrep ':21 |:80 ' || netstat -tulnp | egrep ':21 |:80 '

# Pastikan port 666 tertutup
ss -tlnp | grep :666 || echo "Port 666 closed (OK)"

# ===============================
# Di Eru: Scan port Melkor
# ===============================

# Pastikan nc/netcat terinstall
which nc >/dev/null 2>&1 || { apt update && apt install -y netcat-openbsd; }

# Scan port 21, 80, 666 dan simpan hasil
nc -zv -w 3 192.230.1.2 21 80 666 2>&1 | tee ~/scan_no12_results.txt

# Tampilkan hasil scan
cat ~/scan_no12_results.txt
