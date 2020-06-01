#!/usr/bin/env bash

## Setting up script path
execPath=$(readlink -f $(dirname $0))
scriptSourceBasePath=$execPath/colibri/
#DEBUG# echo $scriptSourceBasePath
sleep 5
## check if user has root privileges or exit

if [ $(whoami) != "root" ] ; then
    echo;
    echo "THIS SCRIPT NEEDS TO BE RUN AS ROOT";
    echo "RUN THIS USING SUDO";
    echo;
    exit 0;
fi

## check if we are on mate or on Ubuntu
Ubuntu_version="Ubuntu_Default"
if ls /usr/bin/*session | grep -q 'mate'; then
    ### setting up env for MATE
    Ubuntu_version="Ubuntu_Mate"
    AUTOLOGIN_FILE="/etc/lightdm/lightdm.conf"
    AUTOLOGIN_BACKUP="/etc/lightdm/lightdm.conf.backup"
    DESKTOP_WALLPAPER_DEST="/usr/share/backgrounds/ubuntu-mate-common/Green-Wall-Logo.png"

else
    ### setting up env for Ubuntu standard
    AUTOLOGIN_FILE="/etc/gdm3/custom.conf"
    AUTOLOGIN_BACKUP="/etc/gdm3/custom.conf.backup"
    DESKTOP_WALLPAPER_DEST="/usr/share/backgrounds/warty-final-ubuntu.png"
fi


##DEBUG##
echo $Ubuntu_version
echo $AUTOLOGIN_FILE
echo $AUTOLOGIN_BACKUP
echo $DESKTOP_WALLPAPER_DEST
##END DEBUG##

## check colibri user configuration
## update and install needed softwares
wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | apt-key add -;
echo "deb http://deb.anydesk.com/ all main" > /etc/apt/sources.list.d/anydesk-stable.list;
apt-get update -y;
apt-get upgrade -y;
apt-get dist-upgrade -y;
apt-get -y install ffmpeg shotwell aptitude \
exfat-fuse exfat-utils conky git anydesk yad;
snap install gimp; 
snap install chromium; 
snap install chromium-ffmpeg; 
snap install vlc;
snap install inkscape; 
snap install audacity;
snap install --classic skype;

## creating a new group for autologin
groupadd nopasswdlogin;

## creating the user colibri
COLIBRI_PASS='Tvqy0jOm0CuFM';
# DEBUG ->> echo $COLIBRI_PASS
useradd --password $COLIBRI_PASS colibri;
usermod -a -G adm,cdrom,audio,dip,video,plugdev,netdev,bluetooth,lpadmin,scanner,sambashare,nopasswdlogin \
-d /home/colibri -s /bin/bash colibri;

## Copying system wide setting
# dir structure
mkdir -v -p /etc/colibri/artwork
mkdir -v -p /etc/colibri/desktop
mkdir -v -p /etc/colibri/fonts
mkdir -v -p /etc/colibri/config
mkdir -v -p /etc/colibri/script


install -v $scriptSourceBasePath/artwork/* /etc/colibri/artwork/
install -v $scriptSourceBasePath/desktop/* /etc/colibri/desktop/
install -v $scriptSourceBasePath/config/* /etc/colibri/config/
install -v $scriptSourceBasePath/fonts/* /etc/colibri/fonts/
install -v $scriptSourceBasePath/script/* /etc/colibri/script/
## made script executables
chmod -v +x /etc/colibri/script/*
chgrp -v -R colibri /etc/colibri
chmod -v -R g+rwx /etc/colibri/

## copying fonts to system wide fonts.

cp -v /etc/colibri/fonts/* /usr/share/fonts/

## regenerates police cache

fc-cache -f -v

## creating user specific structure
mkdir -v -p /home/colibri/Bureau
mkdir -v -p /home/colibri/.config/conky
mkdir -v -p /home/colibri/.config/autostart/

## Setting up desktop shortcuts
cp -v $scriptSourceBasePath/desktop/*.desktop /home/colibri/Bureau/

## setting up conky
cp -v $scriptSourceBasePath/config/*.rc /home/colibri/.config/conky

## setting up autostart script
cp -v $scriptSourceBasePath/config/*.desktop /home/colibri/.config/autostart/
chmod -v +x /home/colibri/.config/autostart/*.desktop

# setting up autorisations
chown -v -R colibri /home/colibri;
chmod -v +x /home/colibri/Bureau/*.desktop

## copying wallpaper

cp -v /etc/colibri/artwork/colibri-wallpaper.png $DESKTOP_WALLPAPER_DEST

## create a marker for first connection
touch /home/colibri/.need-desktop-setup
chown colibri /home/colibri/.need-desktop-setup

## setting up autologin for colibri
### autologin Ubuntu standard
if [ "$Ubuntu_version" = "Ubuntu_Mate" ]; then
    echo "MATE autologin handle"    
    ### autologin Ubuntu Mate
    cat $AUTOLOGIN_FILE | \
    	sed -e 's/#*[[:space:]]*autologin-user=/autologin-user=colibri@/g' | \
    	cut -d "@" -f1 >> tmp.tmp ;
else
    echo "GDM autologin handle"
    ### autologin Ubuntu Standard
    cat $AUTOLOGIN_FILE | \
    	sed -e 's/#[[:space:]]*AutomaticLoginEnable/AutomaticLoginEnable/g' | \
    	sed -e 's/#*[[:space:]]*AutomaticLogin[[:space:]]*=/AutomaticLogin = colibri@/g' | \
    	cut -d "@" -f1 >> tmp.tmp;
fi

mv $AUTOLOGIN_FILE $AUTOLOGIN_BACKUP;

mv tmp.tmp $AUTOLOGIN_FILE;

## reboot
yad --borders=50 --center \
--title "Redémarrage ?" \
--text "Le système va redémarrer dans 10 secondes.\nVoulez-vous redémarrer plus tard ?" \
--timeout="10" \
--timeout-indicator=bottom

if [ $? = 0 ]
then
	yad --title="CIOA!!!" --width="400" --no-buttons --borders=50 --text-align="center" --center --text "<span font_desc='Ubuntu Bold' foreground='#000000'>OK</span>" --timeout 2
	exit 0;	
else
	yad --title="REBOOTING" --width="400" --text-align="center" --no-buttons --borders=50 --center --text "<span font_desc='Ubuntu Bold' foreground='#000000'>REBOOTING...</span>" --timeout 2;
	reboot;

fi
    





