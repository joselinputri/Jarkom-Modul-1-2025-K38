# 📄 Laporan Komdat Jarkom Modul 1 — 2025

## 👥 Anggota Kelompok

| Nama                     | NRP         |
|--------------------------|------------|
| Ahmad Syauqi Reza        | 5027241085 |
| Putri Joselina Silitonga | 5027241116 |

## Deskripsi Laporan 📝

Praktikum ini membahas konfigurasi jaringan dasar menggunakan router, switch, dan client untuk koneksi antar node dan internet. Dilakukan analisis keamanan jaringan melalui sniffing, FTP, upload/download file, simulasi serangan (ping flood & brute force), serta perbandingan Telnet dan SSH. Selain itu, dianalisis serangan Melkor seperti pencurian data, malware, dan email spoofing menggunakan file capture untuk identifikasi serta pencegahan ancaman. 

-------------------------------------------
# Soal 1 - Konfigurasi Topologi Jaringan

Pada praktikum ini digunakan **GNS3 Web UI** dengan host IP `192.230.1.1`.  
Dibuat sebuah project dengan topologi sebagai berikut:

- **Eru** berperan sebagai **router utama**.  
- Router terhubung ke **internet** melalui **NAT1**.  
- Router juga terhubung ke **dua switch**.  
- Masing-masing switch kemudian menghubungkan **dua client**.

Struktur topologi ini dapat dilihat pada gambar berikut:  

# Soal 2 - Koneksi Router ke Internet
Agar **router Eru** dapat terkoneksi ke internet melalui **NAT1**, interface `eth0` dikonfigurasi untuk mendapatkan IP secara dinamis (DHCP):

```bash
auto eth0
iface eth0 inet dhcp
```
### Koneksi ke Switch (IP Statis)
### Interface ke Switch 1
```
auto eth1
iface eth1 inet static
    address 192.230.1.1
    netmask 255.255.255.0
```

### Interface ke Switch 2
```
auto eth2
iface eth2 inet static
    address 192.230.1.2
    netmask 255.255.255.0
```

### Konfigurasi NAT
``
iptables -t nat -A POSTROUTING -s 192.230.1.0/24 -o eth0 -j MASQUERADE
``


#### Konfigurasi Client (IP Statis)
Semua client menggunakan IP statis dengan gateway router yang sesuai.

### Client Switch 1 (Gateway: 192.230.1.1)
#### Melkor (192.230.1.3)
```
auto eth0
iface eth0 inet static
    address 192.230.1.3
    netmask 255.255.255.0
    gateway 192.230.1.1
```

#### Manwe (192.230.1.4)
```
auto eth0
iface eth0 inet static
    address 192.230.1.4
    netmask 255.255.255.0
    gateway 192.230.1.1
```

### Client Switch 2 (Gateway: 192.230.1.2)
#### Varda (192.230.1.5)
``
auto eth0
iface eth0 inet static
    address 192.230.1.5
    netmask 255.255.255.0
    gateway 192.230.1.2
``

### Ulmo (192.230.1.6)
`` 
auto eth0
iface eth0 inet static
    address 192.230.1.6
    netmask 255.255.255.0
    gateway 192.230.1.2
``


# 4. Konfigurasi Otomatis Saat Startup
Perintah yang ditambahkan pada file konfigurasi interface (up ...) untuk memastikan konfigurasi diterapkan setiap node dinyalakan.

#### Router Eru (NAT)
```
iptables -t nat -A POSTROUTING -s 192.230.1.0/24 -o eth0 -j MASQUERADE
```

#### Client (DNS)
```
echo -e "nameserver 8.8.8.8\nnameserver 1.1.1.1" > /etc/resolv.conf
```


# 5. Pengujian Koneksi
Lakukan pengujian dari setiap client.

### Uji ping ke Gateway Switch 1
``ping 192.230.1.1
``

### Uji ping ke Gateway Switch 2
``ping 192.230.1.2
``

# Soal 6 

**Tujuan:**  
Melkor mencoba menyusup ke komunikasi antara **Manwe** dan **Eru**. Kita akan melakukan packet sniffing menggunakan file traffic yang diberikan, lalu memfilter paket berdasarkan IP Manwe (`192.230.1.3`).

---

###  Update sistem dan sertifikat
```bash
apt-get update
apt-get install -y ca-certificates openssl
update-ca-certificates
```
### Download file traffic.zip dari Google Drive
```
wget --no-check-certificate -O traffic.zip "https://drive.google.com/uc?export=download&id=1bE3kF1Nclw0VyKq4bL2VtOOt53IC7lG5"
```
### Filter paket dengan IP Manwe (192.230.1.3)
Display filter di Wireshark:
##### Hanya paket dari Manwe
```
ip.src == 192.230.1.3
```

#### Hanya paket menuju Manwe
```ip.dst == 192.230.1.3```



# Soal 7 - Konfigurasi FTP Server di Node Eru

Pada soal ini, kita diminta untuk membuat FTP Server di node **Eru** dan mengatur hak akses untuk dua user:  
- **ainur** → memiliki hak baca & tulis (`read & write`)  
- **melkor** → tidak memiliki hak akses sama sekali ke direktori `shared`  

Berikut langkah-langkah konfigurasi beserta pembuktian hak akses:

---

### Instalasi FTP Server
```bash
apt update
apt install vsftpd -y
```

### Backup konfigurasi vsftpd
```
cp /etc/vsftpd.conf /etc/vsftpd.conf.bak
```

### Konfigurasi vsftpd
Edit file /etc/vsftpd.conf
```
listen=YES
listen_ipv6=NO
anonymous_enable=NO
local_enable=YES
write_enable=YES
local_umask=022
chroot_local_user=YES
user_sub_token=$USER
local_root=/home/$USER/ftp
allow_writeable_chroot=YES
```

### Membuat user dan direktori FTP
User ainur dengan hak akses baca & tulis
```
adduser ainur
```
```
mkdir -p /home/ainur/ftp/shared
chown -R ainur:ainur /home/ainur/ftp
chmod 755 /home/ainur/ftp
```
```
chown -R ainur:ainur /home/ainur/ftp/shared
chmod 755 /home/ainur/ftp/shared
User melkor tanpa hak akses
```
``
adduser melkor
``

```
mkdir -p /home/melkor/ftp
chown -R melkor:melkor /home/melkor/ftp
chmod 755 /home/melkor/ftp
```

### Restart FTP Service
```
service vsftpd restart
```

### Uji akses user ainur
```
su - ainur
cd ftp/shared
echo "Halo dari ainur" > test.txt
exit
Hasil: File test.txt berhasil dibuat di direktori shared.
```

### Uji akses user melkor dari client FTP
```
ftp 192.230.1.1
```

### Login dengan user melkor
```
Name: melkor
Password: <password_melkor>
cd shared
# Hasil: Gagal mengakses direktori shared
# 550 Failed to change directory
bye
EOF
```

### Uji Koneksi Internet
`` ping google.com
``

