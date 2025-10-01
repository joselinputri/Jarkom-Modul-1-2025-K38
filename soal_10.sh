#!/bin/bash
Baseline ping
# 10 ping normal
ping -c 10 192.230.1.1 | tee /tmp/baseline_ping.txt

ICMP Flood / Ping attack
# 100 ping attack
ping -c 100 192.230.1.1 | tee /tmp/attack_ping.txt

# Atau flood (lab only)
ping -f -c 100 192.230.1.1 | tee /tmp/attack_ping.txt

Ambil ringkasan
# Paket & packet loss
grep 'packets transmitted' /tmp/attack_ping.txt

# Avg RTT
awk -F'/' '/rtt/ {print "attack avg RTT = "$5" ms"}' /tmp/attack_ping.txt

