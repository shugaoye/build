#!/bin/sh

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
