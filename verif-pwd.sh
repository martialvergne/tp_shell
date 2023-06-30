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
	read -p "Entrez le mot de passe à tester : " password
	echo "Vérification du mot de passe saisi"
else 
	password=$1
fi

# On peut utiliser : $(#passwd) pour afficher la taille du mot de passe

test=$(expr length $password)
if [ "$test" -lt 16 ]
then
	echo "Erreur. Le mot de passe saisi contient moins de 16 caractères"
	pwd_suggest=$(openssl rand -base64 16)
	echo "Mot de passe suggéré : $pwd_suggest"
else
	echo "Ok. Le mot de passe saisi contient 16 caractères ou plus"
fi
