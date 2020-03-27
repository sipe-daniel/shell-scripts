#!/bin/bash

echo -e "|***************************VERIFICATION DE L'ACCESSIBILITE DU SITE EN LIGNE***************************|\n" > 'rapport.txt'
echo -e "Le" $(date  +%Y-%m-%d)  >> 'rapport.txt'
echo -e "à" $(date  +%T) "\n\n" >> 'rapport.txt'
echo -e "Liste Url non disponible: \n" >> 'rapport.txt'

cptUrlNonDisponible=0


while read Ligne
do  
	variable="$Ligne"

	
	if [[ `wget -S --spider $variable  2>&1 | grep 'HTTP/1.1 200 OK'` ]] ;then	
	echo "disponible"			
	else
		echo -e 'L url :' $variable  >> 'rapport.txt'
		let cptUrlNonDisponible++
	fi

# url le fichier contenant la liste des url à tester
done < 'url.txt'																	

if [ $cptUrlNonDisponible -eq 0 ] ;then
	echo -e '\t/~#^Tous les url sont disponible^#~/' >> 'rapport.txt'
else
	mail -s "Alert nom de l'organisation" example@yahoo.fr < rapport.txt
fi