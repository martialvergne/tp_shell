#!/bin/bash

##################
#
# Auteur : MV
# Date : 30/06/2023
# Description : Analyse et affiche les users connectés au système
# Syntaxe : ./verif-user.sh
#
##################

echo "Liste des users connectés : "
who

read "Voulez vous désactiver un des users connectés ? (oui ou non)" $rep
if [ $rep="oui"] || [ $rep="o"] || [ $rep="Oui"]
then
    read "Quel user voulez-vous déconnecter ?" $user
    passwd -l $user
fi
