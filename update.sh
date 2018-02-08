#!/bin/bash

logger "Update Script: Starting..."

echo '[*] Refreshing repository cache...'
sudo apt-get update -y
echo '[*] Repository cache refreshed.'

echo '[*] Upgrading all existing packages...'
sudo apt-get upgrade -y
echo '[*] Existing packages upgraded.'

echo '[*] Upgrading Linux distribution (if available)...'
sudo apt-get dist-upgrade -y
echo '[*] Linux distribution upgrade processed.'

echo '[*] Clean up unused and cached packages...'
sudo apt-get autoclean -y
sudo apt-get autoremove -y
echo '[*] Package cleanup complete.'

if [ $(which raspi-config | wc -l) -gt 0 ]; then
        echo '[*] Raspberry Pi Detected.'
        echo '[*] Update the Raspberry Pi firmware to the latest (if available)...'
        sudo rpi-update
        echo '[*] Done updating firmware.'
fi

logger "Update Script: Done."

echo "[*] Rebooting...";

sudo reboot;

# using 'crontab -e' I run:
# 0 3 * * 3 ./update.sh > /home/pi/UpdateLogs/Log_`date +\%m\%d\%y`.log 2>&1
# This outputs to a directory containing all log info
