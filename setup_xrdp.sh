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
