#!/bin/bash


echo -e "|***************************ALERT TAILLE DU DISQUE SUPERIEUR OU EGAL 80%***************************|\n" > 'rapport_size_disk.txt'
echo -e "Le" $(date  +%Y-%m-%d)  >> 'rapport_size_disk.txt'
echo -e "à" $(date  +%T) "\n\n" >> 'rapport_size_disk.txt'


$(df -h --total >> 'rapport_size_disk.txt') 

alert=$(tail 'rapport_size_disk.txt' | grep 'total')

alert=${alert//[[:blank:]]/}

prctageAkt=$(echo "$alert" | cut -d'G' -f4 | cut -d'-' -f1)

echo $prctageAkt

echo -e "\n" >> 'rapport_size_disk.txt'

if [ $prctageAkt = "80%" ]
then			
	echo "La machine " $(hostname) "est superieur ou egal à 80% d'espace utilisé" >> 'rapport_size_disk.txt'											# obligé de mettre then en bas sinon sa dérange
	mail -s "Alert nom_organisation" example@yahoo.fr < rapport_size_disk.txt
fi
