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
#create backup of databases.
#
MYBKPU=root
HOSTN=localhost
PASS='mYpsSw0rD'
DATABASES=" databasename1 databasename2 databasename3 "
MYSQLDUMP=/usr/bin/mysqldump
MYSQLDPATH=/tmp
NAME=$(date +%Y%m%d%H)
# S3 backup storage bucket name.
BUKTNM="salarynow-bkp"
#
for dbase in $DATABASES
do
$MYSQLDUMP -u $MYBKPU  -p$PASS $dbase -h $HOSTN > $MYSQLDPATH/$dbase-$NAME.sql
zip $MYSQLDPATH/$dbase-$NAME.sql.zip $MYSQLDPATH/$dbase-$NAME.sql
rm -rf $MYSQLDPATH/$dbase-$NAME.sql
aws s3 mv $MYSQLDPATH/$dbase-$NAME.sql.zip s3://$BUKTNM/$PROJNAME-$PROJENV/database/"$CHYEAR"/"$CHMONTH"/"$CHDATE"/"$CHHOUR"/
done
