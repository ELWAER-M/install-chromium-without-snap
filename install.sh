#!/bin/sh
sudo apt -y remove chromium-browser chromium-browser-l10n chromium-codecs-ffmpeg-extra
cat <<EOF >/etc/apt/sources.list.d/debian.list
deb http://ftp.debian.org/debian unstable main contrib non-free
EOF
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 0E98404D386FA1D9
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 648ACFD622F3D138
cat <<EOF >/etc/apt/preferences.d/chromium.pref
Package: *
Pin: release o=Ubuntu
Pin-Priority: 500

Package: *
Pin: release o=Debian
Pin-Priority: 300

# Pattern includes 'chromium', 'chromium-browser' and similarly named
# dependencies, and the Debian ffmpeg packages that conflict with the Ubuntu
# versions.
Package: chromium*, libavcodec*, libavformat*, libavutil*, libwebpmux*
Pin: release o=Debian
Pin-Priority: 700
EOF

sudo apt -y update
sudo apt -y -t unstable install chromium chromium-sandbox chromium-l10n chromium-shell chromium-driver libavcodec58 libavformat58 libavutil56

# Add --no-sandbox option to .desktop file, sandbox does not work with proot.
sed -e 's,^Exec=/usr/bin/chromium ,Exec=/usr/bin/chromium --no-sandbox ,' /usr/share/applications/chromium.desktop \
	> ~/.local/share/applications/chromium.desktop

update-desktop-database >/dev/null 2>&1

echo "Ok Done :v"
