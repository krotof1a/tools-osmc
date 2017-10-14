#!/bin/sh

wget -O /media/05edfd7a-0b69-4390-b79d-393fee06c809/backups/domoticz.db "http://192.168.1.20:5665/backupdatabase.php" > /dev/zero 2>&1
chmod 666 /media/05edfd7a-0b69-4390-b79d-393fee06c809/backups/domoticz.db

