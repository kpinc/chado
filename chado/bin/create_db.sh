#!/bin/sh
DBHOST=$1
DBPORT=$2
DBUSER=$3
DBNAME=$4;

dropdb -h $DBHOST -p $DBPORT -U $DBUSER $DBNAME;
createdb -h $DBHOST -p $DBPORT -U $DBUSER $DBNAME;
createlang -h $DBHOST -p $DBPORT -U $DBUSER plpgsql $DBNAME;
echo "database $DBNAME created on $DBHOST:$DBPORT";
true;
