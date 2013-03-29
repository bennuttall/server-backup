#!/bin/bash

echo "$(date) - MySQL Backup started"

DATE=$(date +"%Y-%m-%d")
TIME=$(date +"%H%M%S")
HOUR=$(date +"%H")

USER="root"
PASS="beet"
 
DBS="$(mysql -u $USER -p$PASS -Bse 'show databases')"
 
for DB in $DBS
do
    echo "Backing up database - $DB"

    if [ "$DB" == "information_schema" ] || [ "$DB" == "performance_schema" ] || [ "$DB" == "mysql" ]; then
        PARAMS="--skip-lock-tables"
        BACKUP_DIR="/var/backups/mysql_core/$DATE/$HOUR"
    else
        PARAMS=""
        BACKUP_DIR="/var/backups/users/$DB/$DATE/$HOUR"
    fi

    mkdir -p $BACKUP_DIR

    FILE="$BACKUP_DIR/$DB-$DATE-$TIME.sql"
    mysqldump $PARAMS -u $USER -p$PASS $DB > $FILE
    gzip $FILE
done

echo "$(date) - MySQL Backup performed"
