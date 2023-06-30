#!/bin/bash

##################
#
# Auteur : MV
# Date : 30/06/2023
# Description : Vérification de la complexité des mots de passe saisis
# Syntaxe : ./verif-pwd.sh ou ./verif-pwd.sh <PASSWORD>
#
##################


if [ $# eq 0 ]
then
	read -p "Entrez le mot de passe à tester : " passwd
	echo "Vérification du mot de passe saisi $passwd"
else 
	passwd = $1
	echo "password = $passwd"
fi
