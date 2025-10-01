#!/bin/bash
# Soal 4 - Membuat client bisa internet melalui Eru

# --- DI ERU (Router) ---
# Aktifkan IP forwarding
echo 1 > /proc/sys/net/ipv4/ip_forward

# Pasang iptables kalau belum ada
apt update
apt install -y iptables

# Setup NAT untuk subnet 192.230.1.0/24 dan 192.230.2.0/24 melalui eth0 (koneksi ke internet)
iptables -t nat -A POSTROUTING -s 192.230.1.0/24 -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 192.230.2.0/24 -o eth0 -j MASQUERADE

# --- DI CLIENT (Melkor, Manwe, Varda, Ulmo) ---
# Setting DNS supaya bisa resolve domain
echo -e "nameserver 8.8.8.8\nnameserver 1.1.1.1" > /etc/resolv.conf

# Test koneksi internet
ping -c 3 8.8.8.8
ping -c 3 google.com

