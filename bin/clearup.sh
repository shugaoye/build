#!/bin/bash
#******************************************************************************
#
# Shell Script used to clean up the build environment
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

export D_CURRENT=`pwd`
export D_GOLDFISH_OUT=../build/goldfish
export D_UBOOT_OUT=../build/u-boot
export D_BUSYBOX=./busybox

if [ -f ./u-boot/Makefile ]; then
	export BUILD_DIR=${D_UBOOT_OUT}; cd ${D_UBOOT}; make clean arch=ARM CROSS_COMPILE=arm-none-eabi-
fi

if [ -f ./goldfish/Makefile ]; then
	cd ${D_GOLDFISH_OUT}; make clean arch=ARM CROSS_COMPILE=arm-none-linux-gnueabi-
fi

if [ -f ./busybox/Makefile ]; then
	cd ${D_BUSYBOX}; make arch=ARM CROSS_COMPILE=arm-none-linux-gnueabi- clean
fi

cd ${D_CURRENT}
if [ -f ./bin/rootfs.img ]; then
	rm bin/rootfs.img
fi

if [ -f ./bin/rootfs.img.gz ]; then
	rm bin/rootfs.img.gz
fi

if [ -f ./bin/rootfs.uimg ]; then
	rm bin/rootfs.uimg
fi

if [ -f ./bin/zImage.uimg ]; then
	rm bin/zImage.uimg
fi

if [ -f ./bin/ramdisk.img ]; then
	rm bin/ramdisk.img
fi

if [ -f ./bin/flash.bin ]; then
	rm bin/flash.bin
fi

if [ -f ./bin/system.img ]; then
	rm bin/system.img
fi

rm -rf images
rm -rf system
rm -rf initrd

