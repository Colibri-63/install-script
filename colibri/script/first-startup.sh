#!/usr/bin/env bash

NEED_SETUP=$HOME/.need-desktop-setup

if [ -f "$NEED_SETUP" ]; then
	echo "setup needed"
	chmod +x /home/colibriadmin/Bureau/*.desktop
	gio set "/home/colibriadmin/Bureau/Sctratch Online.desktop" "metadata::trusted" "true"
	gio set "/home/colibriadmin/Bureau/chrome.desktop" "metadata::trusted" "true"
	gio set "/home/colibriadmin/Bureau/ENT Auvergne.desktop" "metadata::trusted" "true"
	gsettings set org.gnome.desktop.lockdown disable-lock-screen 'true'
	rm $NEED_SETUP
else
	echo "already-done"
fi
