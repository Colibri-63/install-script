#!/usr/bin/env bash

execPath=$(readlink -f $(dirname $0))

## check if user has root privileges or exit

if [ $(whoami) != "root" ] ; then
    echo;
    echo "THIS SCRIPT NEEDS TO BE RUN AS ROOT";
    echo "RUN THIS USING SUDO";
    echo;
    exit 0;
fi

## check colibri user configuration

apt-get update -y;
apt-get -y install audacity ffmpeg shotwell aptitude \
exfat-fuse exfat-utils conky;
snap install gimp chromium chromium-ffmpeg vlc inkscape audacity;
snap install --classic skype;
groupadd nopasswdlogin;
COLIBRI_PASS=$(openssl passwd colibri);
echo $COLIBRI_PASS
useradd --password $COLIBRI_PASS colibri;
usermod -a -G adm,cdrom,audio,dip,video,plugdev,netdev,bluetooth,lpadmin,scanner,sambashare,nopasswdlogin \
-d /home/colibri -s /bin/bash colibri;

mkdir -p /home/colibri/Bureau
mkdir -p /home/colibri/.config/conky


cp $execPath/../desktop/*.desktop /home/colibri/Bureau/


chown -R colibri /home/colibri;
chmod +x /home/colibri/Bureau/*.desktop
$(gio set /home/colibri/Bureau/chrome.desktop 'metadata::trusted' true);
$(gio set /home/colibri/Bureau/Sctratch\ Online.desktop 'metadata::trusted' true);
$(gio set /home/colibri/Bureau/ENT\ Auvergne.desktop 'metadata::trusted' true);

### autologin
cat /etc/gdm3/custom.conf | \
	sed -e 's/#[[:space:]]*AutomaticLoginEnable/AutomaticLoginEnable/g' | \
	sed -e 's/#[[:space:]]*AutomaticLogin/AutomaticLogin = colibri@/g' | \
	cut -d "@" -f1 >> tmp.tmp ;

mv /etc/gdm3/custom.conf /etc/colibri/gdm3custom.conf.backup;

mv tmp.tmp /etc/gdm3/custom.conf;


mkdir -p /home/colibri/.config/autostart/


cp $execPath/../config/conky-autostart.desktop /home/colibri/.config/autostart/

cp $execPath/../config/colibri-conky.rc /home/colibri/.config/conky/

wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | apt-key add -;
echo "deb http://deb.anydesk.com/ all main" > /etc/apt/sources.list.d/anydesk-stable.list;
sudo apt-get -y update;
sudo apt-get -y install anydesk;


## check if setup is done

## populate files

## download arch based packages

## install required packets

## setup user colibri
    
## reboot




