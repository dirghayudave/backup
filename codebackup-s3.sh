#!/bin/bash
#
# Project Name and Environment set 
# example(name): website, showbooks
# example(Env): Prod, Dev, Stage, Beta or Test
PROJNAME=
PROJENV=
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
aws s3 mv $TMPPATH/code-$NAME.zip s3://$BUKTNM/$PROJNAME-$PROJENV/code/"$CHYEAR"/"$CHMONTH"/"$CHDATE"/"$CHHOUR"/
