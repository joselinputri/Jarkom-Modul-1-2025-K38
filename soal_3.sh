#!/bin/bash
# Soal 3 - Client bisa saling terhubung

# Melkor
cat <<EOF > /etc/network/interfaces
auto eth0
iface eth0 inet static
    address 192.230.1.2
    netmask 255.255.255.0
    gateway 192.230.1.1
EOF

# Manwe
cat <<EOF > /etc/network/interfaces
auto eth0
iface eth0 inet static
    address 192.230.1.3
    netmask 255.255.255.0
    gateway 192.230.1.1
EOF

# Varda
cat <<EOF > /etc/network/interfaces
auto eth0
iface eth0 inet static
    address 192.230.2.2
    netmask 255.255.255.0
    gateway 192.230.2.1
EOF

# Ulmo
cat <<EOF > /etc/network/interfaces
auto eth0
iface eth0 inet static
    address 192.230.2.3
    netmask 255.255.255.0
    gateway 192.230.2.1
EOF

# Restart network service
systemctl restart networking || service networking restart

