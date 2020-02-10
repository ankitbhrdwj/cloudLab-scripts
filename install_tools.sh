#!/bin/bash

sudo apt update
sudo apt install htop git-gui libnotify4 libnspr4 libnss3 libsecret-1-0 libsecret-common libxkbfile1 libxss1 notification-daemon libxtst-dev

git config --global user.name "Ankit Bhardwaj"
git config --global user.email "bhrdwj.ankit@gmail.com"

wget https://az764295.vo.msecnd.net/stable/ae08d5460b5a45169385ff3fd44208f431992451/code_1.42.0-1580986622_amd64.deb
sudo dpkg -i code_1.42.0-1580986622_amd64.deb
rm code_1.42.0-1580986622_amd64.deb

