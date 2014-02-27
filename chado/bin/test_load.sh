#!/bin/sh

$SHELL create_db.sh $1 $2 $3 $4 \
 && $SHELL create_schema.sh $1 $2 $3 $4 $5
