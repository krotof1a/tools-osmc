#!/bin/sh

cd /home/osmc

sudo apt-get update
sudo apt-get install git-core

# Install TVHeadend and Samba
sudo apt-get install armv7-tvheadend-app-osmc smb-app-osmc

# Clone git repo
git clone https://github.com/krotof1a/tools-osmc.git
if [ ! -f tools-osmc/tv_grab_fr_telerama/tv_grab_fr_telerama ]
then
cd tools-osmc/tv_grab_fr_telerama
wget https://raw.githubusercontent.com/zubrick/tv_grab_fr_telerama/master/tv_grab_fr_telerama
chmod 755 tv_grab_fr_telerama
cd -
fi
if [ ! -L /usr/bin/tv_grab_file ]
then
sudo ln -s /home/osmc/tools-osmc/tv_grab_fr_telerama/tv_grab_fr_telerama /usr/bin/tv_grab_file
fi
sudo apt-get install libxmltv-perl libjson-perl libdigest-hmac-perl libterm-readkey-perl
/usr/bin/tv_grab_file --configure

# Restore recordings symlink
if [ ! -L recordings ]
then
ln -s /media/05edfd7a-0b69-4390-b79d-393fee06c809/recordings/ recordings
else
echo Link already present
fi

# Reinstall Tevi Firmware
sudo cp -f tools-osmc/firmware/* /lib/firmware

# Install FR keyboard support
sudo apt-get install console-data
sudo cp -f tools-osmc/rc.local /etc/rc.local

# Restore config and restart TVHeandend
sudo systemctl stop tvheadend
tar -zxvf /media/05edfd7a-0b69-4390-b79d-393fee06c809/backups/hts.tar.gz
sudo systemctl start tvheadend
