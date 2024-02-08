# https://www.digitalocean.com/community/tutorials/how-to-enable-remote-desktop-protocol-using-xrdp-on-ubuntu-22-04
#!/bin/bash

sudo apt update
sudo apt install xfce4 xfce4-goodies -y

sudo apt install xrdp -y
sudo systemctl status xrdp

sudo systemctl start xrdp

cd ~
echo "xfce4-session" | tee .xsession

sudo systemctl restart xrdp

# Root permission for color
vi /etc/polkit-1/localauthority/50-local.d/color.pkla

[Allow colord for all users]
Identity=unix-user:*
Action=org.freedesktop.color-manager.create-device;org.freedesktop.color-manager.create-profile;org.freedesktop.color-manager.delete-device;org.freedesktop.color-manager.delete-profile;org.freedesktop.color-manager.modify-device;org.freedesktop.color-manager.modify-profile;org.freedesktop.packagekit.system-sources-refresh
ResultAny=no
ResultInactive=no
ResultActive=yes
