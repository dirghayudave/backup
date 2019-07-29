#!/bin/bash
#
#Check s3 path
CHYEAR=$(date +"%Y")
CHMONTH=$(date +"%m")
CHDATE=$(date +"%d")
CHHOUR=$(date +"%H")
#
# Backup of code directory.
#
CODEDUMP=/var/www/html
TMPPATH=/tmp
NAME=$(date +%Y%m%d%H)
# Put your backup storage bucket name.
BUKTNM="my-project-bkp"
#
cd $CODEDUMP/../
zip -r $TMPPATH/code-$NAME.zip html
#
aws s3 mv $TMPPATH/code-$NAME.zip s3://$BUKTNM/code/"$CHYEAR"/"$CHMONTH"/"$CHDATE"/"$CHHOUR"/
