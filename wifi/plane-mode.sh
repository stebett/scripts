#!/usr/bin/fish

set all (sudo wifi off & sudo bluetooth off & sudo killall -quiet wpa_supplicant & sudo killall -quiet dhcpcd & sudo ip link set wlp1s0 down)

echo "All network is down!"
