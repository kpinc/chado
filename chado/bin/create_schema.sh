#!/bin/sh
DBHOST=$1
DBPORT=$2
DBUSER=$3
DBNAME=$4
SCHEMA=$5

{ printf 'DROP SCHEMA %s CASCADE;\n' $SCHEMA; \
  printf 'DROP SCHEMA frange CASCADE;\n'; \
  printf 'DROP SCHEMA genetic_code CASCADE;\n'; \
  printf 'DROP SCHEMA so CASCADE;\n' ; } \
  | psql -h $DBHOST -p $DBPORT -U $DBUSER $DBNAME
printf 'Errors regards missing schemas may be safely ignored.'

! { printf 'CREATE SCHEMA %s;\n' $SCHEMA ; \
    cat modules/complete.sql ; } \
  | psql -h $DBHOST -p $DBPORT -U $DBUSER $DBNAME 2>&1 \
  | grep -E 'ERROR|FATAL|No such file or directory' \
  && echo "schema $SCHEMA installed in database $DBNAME"
