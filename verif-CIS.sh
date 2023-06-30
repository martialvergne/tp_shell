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
findmnt --kernel /tmp
if [ $? -ne 0 ]
then
	systemctl- is-enabled tmp.mount
	if [ $? -ne 0 ]
	then
		echo "La configuration est non conforme, modification du fstab"
		systemctl unmask tmp.mount
		echo "tmpfs	/tmp	tmpfs	defaults,rw,nosuid,nodev,noexec,relatime,size=2G	0	0" >> /etc/fstab
		echo "[X] 1.1.2.1 - Le montage /tmp est sur un montage séparée"
		echo "[X] 1.1.2.2 - Nodev option set on /tmp"
		echo "[X] 1.1.2.3 - Noexec option set on /tmp"
		echo "[X] 1.1.2.4 - Nosuid option set on /tmp"
		exit 0
	fi
	findmnt --kernel /tmp
fi

findmnt --kernel /tmp | grep nodev
if [ $? -ne 0 ]
then
	echo "[ ] 1.1.2.2 - Nodev option not set on /tmp" >> output.txt
else
	echo "[X] 1.1.2.2 - Nodev option set on /tmp" >> output.txt
fi
mount -o remount /tmp

findmnt --kernel /tmp | grep noexec
if [ $? -ne 0 ]
then
	echo "[ ] 1.1.2.3 - Noexec option not set on /tmp" >> output.txt
else
	echo "[X] 1.1.2.3 - Noexec option set on /tmp" >> output.txt
fi
mount -o remount /tmp

findmnt --kernel /tmp | grep nosuid
if [ $? -ne 0 ]
then
	echo "[ ] 1.1.2.4 - Nosuid option not set on /tmp" >> output.txt
else
	echo "[X] 1.1.2.4 - Nosuid option set on /tmp" >> output.txt
fi
mount -o remount /tmp
