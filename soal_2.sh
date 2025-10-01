#!/bin/bash
# Soal 2 - Eru bisa akses internet

# Aktifkan IP forwarding
echo 1 > /proc/sys/net/ipv4/ip_forward

# Install iptables jika belum ada
which iptables >/dev/null 2>&1 || (apt update && apt install -y iptables)

# Setup NAT untuk internet (eth0 = interface ke NAT/internet)
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

# Simpan aturan iptables supaya bisa restore setelah reboot
mkdir -p /etc/iptables
iptables-save > /etc/iptables/rules.v4

# Tambahkan iptables restore dan IP forwarding ke rc.local supaya persisten
grep -q "iptables-restore" /etc/rc.local 2>/dev/null || {
    echo "iptables-restore < /etc/iptables/rules.v4" >> /etc/rc.local
    echo "echo 1 > /proc/sys/net/ipv4/ip_forward" >> /etc/rc.local
    chmod +x /etc/rc.local
}

# Tambahkan DNS
cat <<EOF > /etc/resolv.conf
nameserver 8.8.8.8
nameserver 1.1.1.1
EOF

