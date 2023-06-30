#!/bin/bash

##################
#
# Auteur : MV
# Date : 30/06/2023
# Description : Vérification de la complexité des mots de passe saisis
# Syntaxe : ./verif-pwd.sh ou ./verif-pwd.sh <PASSWORD>
#
##################

#Vérification si le mot de passe est passé en paramètre au lancement du script
if [ $# -eq 0 ]
then
	read -sp "Entrez le mot de passe à tester : " password
	echo "\n Vérification du mot de passe saisi"
else 
	password=$1
fi

# On peut utiliser : $(#passwd) pour afficher la taille du mot de passe

test=$(expr length $password)
if [ $(#passwd) -lt 16 ]
then
	echo "Erreur. Le mot de passe saisi contient moins de 16 caractères"
	pwd_suggest=$(openssl rand -base64 12)
	echo "Mot de passe suggéré : $pwd_suggest"
else
	echo "Ok. Le mot de passe saisi contient 16 caractères ou plus"
fi
if [[ $password=~[A-Z] ]] && [[ $password=~[a-z] ]] && [[ $password=~[0-9] ]] && [[ $password=~[@\#\$\%\!\?\&\+\=\;] ]]
then
	echo "La complexité du mot de passe est suffisante"
else
	echo "La complexité du mot de passe n'est pas suffisante"
	pwd_suggest=$(openssl rand -base64 16)
	echo "Mot de passe suggéré : $pwd_suggest"
fi

