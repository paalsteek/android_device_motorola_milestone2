#!/bin/sh

VENDOR=motorola
DEVICE=milestone2

BASE=../../../vendor/$VENDOR/$DEVICE/proprietary
rm -rf $BASE/*

for FILE in `cat proprietary-files.txt | grep -v ^# | grep -v ^$`; do
    DIR=`dirname $FILE`
    if [ ! -d $BASE/$DIR ]; then
        mkdir -p $BASE/$DIR
    fi
    if [ $1 = "device" ]; then
	adb pull /system/$FILE "$BASE/$FILE"

    else
	cp  "$1/system/$FILE" "$BASE/$FILE" 
    fi
done

./setup-makefiles.sh
