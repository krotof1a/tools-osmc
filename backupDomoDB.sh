#!/bin/sh

wget -O /media/sda1/backups/domoticz.db "http://localhost:5665/backupdatabase.php" > /dev/zero 2>&1
chmod 666 /media/sda1/backups/domoticz.db

