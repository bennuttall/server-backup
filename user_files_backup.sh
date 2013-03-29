#!/bin/bash

echo "$(date) - File Backup started"

DATE=$(date +"%Y-%m-%d")
TIME=$(date +"%H%M%S")
HOUR=$(date +"%H")

USERS=(
ben
mcrraspjam
)

for USER in "${USERS[@]}"
do
    echo "Backing up user files - $USER"

    BACKUP_DIR="/var/backups/users/$USER/$DATE/$HOUR"

    mkdir -p $BACKUP_DIR

    BACKUP_LOCATION="$BACKUP_DIR/$USER-$DATE-$TIME.tar.gz"
    HOME_LOCATION="/home/"
    tar czC $HOME_LOCATION $USER > $BACKUP_LOCATION
done

echo "$(date) - File Backup performed"
