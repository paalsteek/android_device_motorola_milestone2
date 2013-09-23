#!/bin/bash - 
#===============================================================================
#
#          FILE: build-recovery.sh
# 
#         USAGE: ./build-recovery.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2013年08月06日 07时51分22秒 CST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
DEVICE_PATH="$2"
OUT_PATH="$3"

function extractRamdisk () {
	if [ -d ramdisk-recovery ]; then
		cd ramdisk-recovery
		rm * -rf
	else
		mkdir ramdisk-recovery
	        cd ramdisk-recovery
	fi
        gzip -dc ./bootmenu/2nd-boot/ramdisk-recovery | cpio -i
}

function createRamdisk() {
	
	cd "$DEVICE_PATH/ramdisk-recovery"
        for CHK_PATH in dev data proc sys system/bin tmp
        do
        	if [ ! -d "$CHK_PATH" ]; then
                        echo "Create lost path $CHK_PATH"
	        	mkdir -p $CHK_PATH
        	fi
        done
	#cpio -i -t -F ../bootmenu/2nd-boot/ramdisk-recovery.cpio | cpio -o -H newc -O ../bootmenu/2nd-boot/ramdisk-recovery-new.cpio
	echo "install recovery: $OUT_PATH/system/bootmenu/2nd-boot/ramdisk-recovery"
	rm -f $OUT_PATH/ramdisk-recovery.cpio.gz $OUT_PATH/ramdisk-recovery.cpio
        find . | cpio -o -H newc -O $OUT_PATH/ramdisk-recovery.cpio
        gzip $OUT_PATH/ramdisk-recovery.cpio 
	mv $OUT_PATH/ramdisk-recovery.cpio.gz $OUT_PATH/system/bootmenu/2nd-boot/ramdisk-recovery
	
	
}


if [ "$1" = "-e" ]; then
	extractRamdisk;
elif [ "$1" = "-c" ]; then 
	createRamdisk;
fi


