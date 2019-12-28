#!/usr/bin/sh

sudo rfkill block all 
sudo killall -quiet pulseaudio
sudo killall -quiet bluetoothd
sudo killall -quiet wpa_supplicant 
sudo killall -quiet dhcpcd 
sudo ip link set wlp1s0 down

echo "All network is down!"
