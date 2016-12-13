#!/bin/bash

# This script deletes several mysql database that starts with a common pattern

DB_STARTS_WITH=""
MUSER="root"
MPWD=""
MYSQL="mysql"

DBS="$($MYSQL -u $MUSER -p"$MPWD" -Bse 'show databases')"
for db in $DBS; do

  if [[ "$db" == $DB_STARTS_WITH*  ]]; then
        echo "Deleting $db"
            $MYSQL -u $MUSER -p"$MPWD" -Bse "drop database $db"
   fi

done
