#!/bin/bash

# Function to check and restore idir
restore_idir() {

    if [ ! -d "$IDIR_PATH" ]; then
        echo "Current idir not found. Checking backup location..."
        if [ -d "$BACKUP_IDIR_PATH" ]; then
            echo "Restoring idir from backup location..."
            cp -r "$BACKUP_IDIR_PATH" "$IDIR_PATH"
            echo "idir restored successfully."
        else
            echo "No idir found in backup location. A fresh scan will be performed."
        fi
    else
        echo "idir exists. Proceeding with incremental scan."
    fi
}
  
# Function to backup idir
backup_idir() {
    if [ -d "$IDIR_PATH" ]; then
        echo "Backing up idir to backup location..."
        rm -rf "$BACKUP_IDIR_PATH" # Clean previous backup
        cp -r "$IDIR_PATH" "$BACKUP_IDIR_PATH"
        echo "idir backed up successfully."
    else
        echo "No idir found to back up."
    fi
}

# Main script execution
case $1 in
    restore)
        restore_idir
        ;;
    backup)
        backup_idir
        ;;
    *)
        echo "Usage: $0 {restore|backup}"
        exit 1
        ;;
esac