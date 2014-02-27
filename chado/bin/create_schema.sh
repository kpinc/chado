#!/bin/sh
DBHOST=$1
DBPORT=$2
DBUSER=$3
DBNAME=$4
SCHEMA=$5

! cat modules/complete.sql \
  | psql -h $DBHOST -p $DBPORT -U $DBUSER $DBNAME 2>&1 \
  | grep -E 'ERROR|FATAL|No such file or directory' \
  && echo "schema $SCHEMA installed in database $DBNAME"
