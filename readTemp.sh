#!/bin/sh

ONE_WIRE_DEVICE="10-0008028a8e70"
DOMOTICZ_IP="192.168.0.17"
DOMOTICZ_PORT="5665"
DOMOTICZ_IDX="69"
WAIT="60"

while [ 1 = 1 ]
do
	READ=`cat /sys/bus/w1/devices/${ONE_WIRE_DEVICE}/w1_slave`
	CRC=`echo $READ | cut -f12 -d' '`
	if [ "$CRC" = "YES" ]
	then
		TEMP=`echo $READ | cut -f22 -d' ' | cut -f2 -d'='`
		TEMPE=`expr $TEMP / 1000`
		TEMPC=`expr $TEMPE - 1`
		TEMPR=`expr $TEMP % 1000 | cut -c 1-2`
		#echo Original=$TEMPE.$TEMPR
		#echo Corrected=$TEMPC.$TEMPR
		curl "http://$DOMOTICZ_IP:$DOMOTICZ_PORT/json.htm?type=command&param=udevice&idx=$DOMOTICZ_IDX&nvalue=0&svalue=$TEMPC.$TEMPR" > /dev/zero 2>&1
	fi
	sleep $WAIT
done
