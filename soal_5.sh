#!/bin/bash
# Soal 5 - Membuat konfigurasi tetap setelah reboot

# --- DI ERU (Router) ---
# Aktifkan IP forwarding sekarang
echo 1 > /proc/sys/net/ipv4/ip_forward

# Pasang iptables kalau belum ada
apt update
apt install -y iptables

# Setup NAT untuk subnet 192.230.1.0/24 dan 192.230.2.0/24 melalui eth0
iptables -t nat -A POSTROUTING -s 192.230.1.0/24 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 192.230.2.0/24 -o eth0 -j MASQUERADE

# Buat direktori untuk menyimpan aturan iptables
mkdir -p /etc/iptables
iptables-save > /etc/iptables/rules.v4

# Tambahkan auto-load saat boot dengan /etc/rc.local
# Cek dulu ada rc.local, jika tidak buat
if [ ! -f /etc/rc.local ]; then
  echo -e "#!/bin/bash\nexit 0" > /etc/rc.local
fi
chmod +x /etc/rc.local

# Tambahkan perintah agar IP forwarding dan iptables load saat boot
grep -qxF "echo 1 > /proc/sys/net/ipv4/ip_forward" /etc/rc.local || \
  sed -i "/^exit 0/i echo 1 > /proc/sys/net/ipv4/ip_forward" /etc/rc.local

grep -qxF "iptables-restore < /etc/iptables/rules.v4" /etc/rc.local || \
  sed -i "/^exit 0/i iptables-restore < /etc/iptables/rules.v4" /etc/rc.local

# --- DI CLIENT (Melkor, Manwe, Varda, Ulmo) ---
# Simpan DNS agar tetap ada setelah reboot
echo -e "nameserver 8.8.8.8\nnameserver 1.1.1.1" > /etc/resolv.conf

