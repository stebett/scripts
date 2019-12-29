#!/usr/bin/sh

sudo rfkill block bluetooth
killall -quiet pulseaudio
sudo cpupower frequency-set -g powersave
