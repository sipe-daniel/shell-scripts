#!/bin/bash

sudo -u postgres -H -- psql -d Jaspersoft_bd2 -c "SELECT count(*) FROM personnes" > `argument.txt`
if [ -z `cat argument.txt` ] ;then
  notify-send  'verification effectuée ' 'la base de donnée est n est pas en ligne' -u normal -t 7500 -i error
else
  notify-send  'verification effectuée ' 'la base de donnée est en ligne' -u normal -t 7500 -i checkbox-checked-symbolic
fi