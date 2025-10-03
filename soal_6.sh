#!/bin/bash
# soal_6.sh

# ️⃣ Update repo & install sertifikat agar sistem bisa trust CA
apt-get update
apt-get install -y ca-certificates openssl
update-ca-certificates

# ️⃣ Download file traffic.zip dari Google Drive
wget --no-check-certificate -O traffic.zip "https://drive.google.com/uc?export=download&id=1bE3kF1Nclw0VyKq4bL2VtOOt53IC7lG5"

# Hasil:
# - Sistem sudah bisa trust sertifikat (CA updated)
# - File traffic.zip tersimpan di /root/traffic.zip
# - Langkah selanjutnya: ekstrak / analisis pcap

#Filter paket dengan IP Manwe (192.230.1.3)
 "ip.addr == 192.230.1.3" 
