#!/usr/bin/fish

sudo rfkill block bluetooth
sudo cpupower frequency-set -g powersave
