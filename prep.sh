#******************************************************************************
#
# Script to generte ram disk
#
# Copyright (c) 2014 Roger Ye.  All rights reserved.
# Software License Agreement
# 
# 
# THIS SOFTWARE IS PROVIDED "AS IS" AND WITH ALL FAULTS.
# NO WARRANTIES, WHETHER EXPRESS, IMPLIED OR STATUTORY, INCLUDING, BUT
# NOT LIMITED TO, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE APPLY TO THIS SOFTWARE. The AUTHOR SHALL NOT, UNDER
# ANY CIRCUMSTANCES, BE LIABLE FOR SPECIAL, INCIDENTAL, OR CONSEQUENTIAL
# DAMAGES, FOR ANY REASON WHATSOEVER.
#
#******************************************************************************

#!/bin/sh

if [ -x images ]; then
        echo "Find images folder."
else
        echo "Cannot images folder."
	if [ -z $AndroidSDK ]; then
		AndroidSDK=AndroidSDK=$HOME/android-sdk-linux
		echo "Not find SDK PATH. Set it to $AndroidSDK"
	else
		echo "Find SDK PATH."
	fi
	mkdir images
	ln -s $HOME/android-sdk-linux/system-images/android-15/default/armeabi-v7a/ramdisk.img images/ramdisk.img
	ln -s $HOME/android-sdk-linux/system-images/android-15/default/armeabi-v7a/system.img images/system.img
fi

if [ -f initrd/init.rc ]; then
    echo "found initrd/init.rc."
else
    echo "Cannot find initrd/init.rc. Extract image..."
    # tar xvfz images/initrd.tar.gz
    mkdir -p initrd
    cd initrd
    gzip -dc < ../images/ramdisk.img | cpio --extract
    cd ..
fi

#
# yaffs2 tools can be found at https://code.google.com/p/yaffs2utils/
#
if [ -f system/build.prop ]; then
    echo "found system/build.prop."
else
    echo "Cannot find system/build.prop. Extract image..."
    mkdir -p system
    cd system
    unyaffs ../images/system.img
fi
