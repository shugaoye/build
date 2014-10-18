#******************************************************************************
#
# Makefile - Makefile of u-boot & goldfish kernel
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

# This is the makefile for goldfish serial device testing

#
# The base directory.
#
D_GOLDFISH_OUT=${HOME}/src/build/goldfish
D_UBOOT_OUT=${HOME}/src/build/u-boot
D_UBOOT=../u-boot
D_GOLDFISH=../goldfish
D_BUSYBOX=./busybox
D_BUSYBOX_SRC=../../busybox
D_ROOTFS=./initrd
F_RAMDISK=./bin/ramdisk.img
F_SYSTEM=./bin/system.img

all:u-boot_build goldfish_build bb rootfs flash.bin
config: u-boot_config goldfish_config bb_config

run_zImage:
	emulator -verbose -show-kernel -netfast -avd hd2 -system ${F_SYSTEM} -ramdisk ${F_RAMDISK} -qemu -serial stdio -monitor telnet::6666,server -kernel ${D_GOLDFISH_OUT}/arch/arm/boot/zImage

run:
	emulator -verbose -show-kernel -netfast -avd hd2 -system ${F_SYSTEM} -ramdisk ${F_RAMDISK} -qemu -serial stdio -monitor telnet::6666,server -kernel bin/flash.bin

u-boot_config:
	export BUILD_DIR=${D_UBOOT_OUT}; cd ${D_UBOOT}; make goldfish_config arch=ARM CROSS_COMPILE=arm-none-eabi-

u-boot_build:
	export BUILD_DIR=${D_UBOOT_OUT}; cd ${D_UBOOT}; make all arch=ARM CROSS_COMPILE=arm-none-eabi-

u-boot_run:
	emulator -verbose -show-kernel -netfast -avd hd2 -system ${F_SYSTEM} -ramdisk ${F_RAMDISK} -qemu -serial stdio -monitor telnet::6666,server -kernel ${D_UBOOT_OUT}/u-boot

u-boot_debug:
	ddd --debugger arm-none-eabi-gdb ${D_UBOOT_OUT}/u-boot &
	emulator -verbose -show-kernel -netfast -avd hd2 -system ${F_SYSTEM} -ramdisk ${F_RAMDISK} -qemu -serial stdio -monitor telnet::6666,server -s -S -kernel ${D_UBOOT_OUT}/u-boot

goldfish_config:
	mkdir -p ${D_GOLDFISH_OUT}
	cd ${D_GOLDFISH}; make O=${D_GOLDFISH_OUT} goldfish_armv7_defconfig arch=ARM CROSS_COMPILE=arm-none-linux-gnueabi-

goldfish_build:
	mkdir -p bin
	cd ${D_GOLDFISH_OUT}; make arch=ARM CROSS_COMPILE=arm-none-linux-gnueabi-
	mkimage -A arm -C none -O linux -T kernel -d ${D_GOLDFISH_OUT}/arch/arm/boot/zImage -a 0x00010000 -e 0x00010000 bin/zImage.uimg

goldfish_debug:
	ddd --debugger arm-none-eabi-gdb ${D_GOLDFISH_OUT}/vmlinux &
	emulator -verbose -show-kernel -netfast -avd hd2 -system ${F_SYSTEM} -ramdisk ${F_RAMDISK} -qemu -serial stdio -monitor telnet::6666,server -s -S -kernel ${D_GOLDFISH_OUT}/arch/arm/boot/zImage

goldfish_run:
	emulator -verbose -show-kernel -netfast -avd hd2 -system ${F_SYSTEM} -ramdisk ${F_RAMDISK} -qemu -serial stdio -monitor telnet::6666,server -kernel ${D_GOLDFISH_OUT}/arch/arm/boot/zImage

bb_config:
	mkdir -p busybox
	cd ${D_BUSYBOX}; make KBUILD_SRC=${D_BUSYBOX_SRC} -f ${D_BUSYBOX_SRC}/Makefile arch=ARM CROSS_COMPILE=arm-none-linux-gnueabi- defconfig
	cp busybox.config ${D_BUSYBOX}/.config

bb:
	cd ${D_BUSYBOX}; make arch=ARM CROSS_COMPILE=arm-none-linux-gnueabi- install

rootfs:
#	find ${D_ROOTFS} | cpio -oc | gzip -c -9 >| bin/rootfs.img
	./prep.sh
	cd ${D_ROOTFS} ; cpio -o -H newc -O ../bin/ramdisk.img < ../initrd.list
	gzip bin/ramdisk.img; mv bin/ramdisk.img.gz bin/ramdisk.img
	cp bin/ramdisk.img bin/rootfs.img
	gzip -c bin/rootfs.img > bin/rootfs.img.gz
	mkimage -A arm -C none -O linux -T ramdisk -d bin/rootfs.img.gz -a 0x00800000 -e 0x00800000 bin/rootfs.uimg
	cp ${D_BUSYBOX}/busybox system/xbin/busybox
	cp bin/rootfs.uimg system/ramdisk.uimg
	cp bin/zImage.uimg system/zImage.uimg
	mkyaffs2image system bin/system.img

flash.bin:
	dd if=/dev/zero of=bin/flash.bin bs=1 count=6M
	dd if=${D_UBOOT_OUT}/u-boot.bin of=bin/flash.bin conv=notrunc bs=1
	dd if=bin/zImage.uimg of=bin/flash.bin conv=notrunc bs=1 seek=2M
	dd if=bin/rootfs.uimg of=bin/flash.bin conv=notrunc bs=1 seek=4M

clean:
	export BUILD_DIR=${D_UBOOT_OUT}; cd ${D_UBOOT}; make clean arch=ARM CROSS_COMPILE=arm-none-eabi-
	cd ${D_GOLDFISH_OUT}; make clean arch=ARM CROSS_COMPILE=arm-none-linux-gnueabi-
	cd ${D_BUSYBOX}; make arch=ARM CROSS_COMPILE=arm-none-linux-gnueabi- clean
	rm bin/rootfs.img  bin/rootfs.img.gz  bin/rootfs.uimg  bin/zImage.uimg bin/ramdisk.img bin/flash.bin bin/system.img
	rm -rf system
	rm -rf initrd

distclean:
	cd ${D_UBOOT}; make distclean
	cd ${D_GOLDFISH}; make distclean
	cd ${D_BUSYBOX}; make arch=ARM CROSS_COMPILE=arm-none-linux-gnueabi- distclean
	rm bin/rootfs.img  bin/rootfs.img.gz  bin/rootfs.uimg  bin/zImage.uimg bin/ramdisk.img
	rm -rf busybox

