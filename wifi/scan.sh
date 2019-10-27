#!/usr/bin/fish

# Turn on wifi
# set WIFION (sudo wifi on)
# switch "$WIFION"
#     case "*on*"
#         echo "[*] Wifi Enabled..."
#      case "*"
#          echo "[!] Wifi is having problems!"
#          echo "$WIFION"
#          exit
# end

# Be sure that there is no previous instance of wpa_supplicant
# And that wifi interface is up and fine
sudo killall -quiet wpa_supplicant
sudo ip link set wlp1s0 down
sudo ip link set wlp1s0 up

# Scan for SSIDs (wifi names)
set names (sudo iw dev wlp1s0 scan | grep SSID)

switch "$names"
    case "*Ginko*"
        set TARGET Phone
    case "*EOLO extender*"
        set TARGET eolo-extender
    case "*EOLO*"
        set TARGET eolo
    case "*TISCALI_6C96*"
        set TARGET tuck
    case "*WOW FI - FASTWEB"
        set TARGET wowfi
    case "*Klodi*"
        set TARGET klodi
    case "*Mary*"
        set TARGET mary
    case "*eduroam*"
        set TARGET eduroam
    case "*"
        set TARGET 0
end

# Output target wifi
switch "$TARGET"
    case 0
        echo "[!] No Connection Aviable!"
        exit
    case "*"
        echo "[*] Connecting to $TARGET"
end


# Connect
set CONN (sudo wpa_supplicant -B -i wlp1s0 -c /etc/wpa_supplicant/"$TARGET".conf)

switch "$CONN"
    case '*p2p'
        echo "[!] Not connected, kill wpa_supplicant?"
        exit
    case "*Successfully*"
        echo "[*] Connecting..."
    case '*'
        echo "[!] Not connected, turn on Hotspot?"
        exit
end

# Ask for ip, send it to /dev/null to omit output from script
sudo dhcpcd wlp1s0 > /dev/null ^ /dev/null

wait # Wait that previous processes end

# Test connection
set disco 1

while test $disco -eq 1
    sleep 3
    wget -q --spider google.com
    set connect $status
    switch $connect
        case 0
            echo "[*] Online!"
            set disco 0
        case '*'
            echo "[!] Offline"
            echo "[!] Trying again..."
    end
end

