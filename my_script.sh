#!/bin/bash
apt update
apt install wget -y
mkdir /root/bot_files
cd /root/bot_files
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

# Try to install Chrome
if ! dpkg -i google-chrome-stable_current_amd64.deb; then
    echo "Chrome installation failed. Attempting to fix dependencies..."
    apt -f install -y
    # Try installing Chrome again after fixing dependencies
    if ! dpkg -i google-chrome-stable_current_amd64.deb; then
        echo "Chrome installation failed again. Exiting."
        exit 1
    fi
fi

#wget https://github.com/juanbailon/test-bin-download/raw/main/test_sel_bin
#chmod +x test_sel_bin
#./test_sel_bin > sel_bin.logs


timedatectl set-timezone America/Bogota
