#!/bin/sh
sudo apt remove chromium-browser chromium-browser-l10n chromium-codecs-ffmpeg-extra
echo "deb http://deb.debian.org/debian buster main
deb http://deb.debian.org/debian buster-updates main
deb http://deb.debian.org/debian-security buster/updates main" > /etc/apt/sources.list.d/debian.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys DCC9EFBF77E11517
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 648ACFD622F3D138
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys AA8E81B4331F7F50
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 112695A0E562B32A
echo "# Note: 2 blank lines are required between entries
Package: *
Pin: release a=eoan
Pin-Priority: 500

Package: *
Pin: origin "ftp.debian.org"
Pin-Priority: 300

# Pattern includes 'chromium', 'chromium-browser' and similarly
# named dependencies:
Package: chromium*
Pin: origin "ftp.debian.org"
Pin-Priority: 700" > /etc/apt/preferences.d/chromium.pref
sudo apt update
sudo apt install chromium -y
echo "Ok Done :v"
