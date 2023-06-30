#!/bin/bash

##################
#
# Auteur : MV
# Date : 22/06/2023
# Description : Vérification des recommandations CIS pour Debian
# Syntaxe :
#
##################

echo "Vérification des recommandations CIS"
findmnt --kernel /tmp > /dev/null 2>&1
if [ $? -ne 0 ]
then
	systemctl is-enabled tmp.mount > /dev/null 2>&1
	if [ $? -ne 0 ]
	then
		echo "La configuration est non conforme, modification du fstab"
		systemctl unmask tmp.mount > /dev/null 2>&1
		echo "tmpfs	/tmp	tmpfs	defaults,rw,nosuid,nodev,noexec,relatime,size=2G	0	0" >> /etc/fstab
		echo "[X] 1.1.2.1 - Le montage /tmp est sur un montage séparée"
		echo "[X] 1.1.2.2 - Nodev option set on /tmp"
		echo "[X] 1.1.2.3 - Noexec option set on /tmp"
		echo "[X] 1.1.2.4 - Nosuid option set on /tmp"
		mount -a
		exit 0
	fi
	findmnt --kernel /tmp > /dev/null 2>&1
	
else
	echo "[X] 1.1.2.1 - Le montage /tmp est sur un montage séparé" 
fi

findmnt --kernel /tmp | grep nodev > /dev/null 2>&1
if [ $? -ne 0 ]
then
	echo "[ ] 1.1.2.2 - Nodev option not set on /tmp" 
else
	echo "[X] 1.1.2.2 - Nodev option set on /tmp" 
fi
mount -o remount /tmp 

findmnt --kernel /tmp | grep noexec > /dev/null 2>&1
if [ $? -ne 0 ]
then
	echo "[ ] 1.1.2.3 - Noexec option not set on /tmp"
else
	echo "[X] 1.1.2.3 - Noexec option set on /tmp"
fi
mount -o remount /tmp

findmnt --kernel /tmp | grep nosuid > /dev/null 2>&1
if [ $? -ne 0 ]
then
	echo "[ ] 1.1.2.4 - Nosuid option not set on /tmp"
else
	echo "[X] 1.1.2.4 - Nosuid option set on /tmp"
fi
mount -o remount /tmp
