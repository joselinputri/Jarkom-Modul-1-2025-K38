# 1. Download file cuaca.zip dari Google Drive
wget --no-check-certificate 'https://drive.google.com/uc?export=download&id=11ra_yTV_adsPIXeIPMSt0vrxCBZu0r33' -O /root/cuaca.zip

# 2. Cek file hasil download
ls -l /root/cuaca.zip

# 3. Jika direktori tujuan di Eru belum ada, buat via SSH
ssh ainur@192.230.2.1 <<EOF
mkdir -p ~/shared
chmod 700 ~/shared
exit
EOF

# 4. Upload cuaca.zip ke server FTP Eru (user ainur)
ftp 192.230.2.1 <<EOF
user ainur [password_ainur]
cd shared
put /root/cuaca.zip
ls
bye
EOF

# 5. Cek interface aktif di Ulmo sebelum capture
ip a

# 6. Capture paket FTP dengan tcpdump
# Ganti eth0 dengan interface yang aktif
sudo tcpdump -i eth0 -w /root/capture.pcap
# Stop dengan Ctrl+C setelah transfer selesai

