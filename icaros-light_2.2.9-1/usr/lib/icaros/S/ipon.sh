#!/bin/bash

# Network interface connected to internet
NET=`route |grep default|awk '{ print $8 }'`

tunctl -b -g aros -t aros0
ifconfig aros0 192.168.166.1
ifconfig aros0 up
route add -host 192.168.166.2 dev aros0
chmod 666 /dev/net/tun
sysctl -w net.ipv4.ip_forward=1
iptables -t nat -A POSTROUTING -o $NET -j MASQUERADE
