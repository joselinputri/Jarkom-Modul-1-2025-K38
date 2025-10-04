# 📄 Laporan Komdat Jarkom Modul 1 — 2025

## 👥 Anggota Kelompok

| Nama                     | NRP         |
|--------------------------|------------|
| Ahmad Syauqi Reza        | 5027241085 |
| Putri Joselina Silitonga | 5027241116 |

## Deskripsi Laporan 📝

Praktikum ini membahas konfigurasi jaringan dasar menggunakan router, switch, dan client untuk koneksi antar node dan internet. Dilakukan analisis keamanan jaringan melalui sniffing, FTP, upload/download file, simulasi serangan (ping flood & brute force), serta perbandingan Telnet dan SSH. Selain itu, dianalisis serangan Melkor seperti pencurian data, malware, dan email spoofing menggunakan file capture untuk identifikasi serta pencegahan ancaman. 


# Soal 1 - Konfigurasi Topologi Jaringan

Pada praktikum ini digunakan **GNS3 Web UI** dengan host IP `192.230.1.1`.  
Dibuat sebuah project dengan topologi sebagai berikut:

- **Eru** berperan sebagai **router utama**.  
- Router terhubung ke **internet** melalui **NAT1**.  
- Router juga terhubung ke **dua switch**.  
- Masing-masing switch kemudian menghubungkan **dua client**.  

Struktur topologi ini dapat dilihat pada gambar berikut:  

