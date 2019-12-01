#!/usr/bin/fish

set all (sudo rfkill block all && sudo killall -quiet wpa_supplicant & sudo killall -quiet dhcpcd & sudo ip link set wlp1s0 down)

echo "All network is down!"
