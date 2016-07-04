#!/bin/sh

wget -O /media/sda1/backups/domoticz.db "http://192.168.1.17:5665/backupdatabase.php" > /dev/zero 2>&1
chmod 666 /media/sda1/backups/domoticz.db

