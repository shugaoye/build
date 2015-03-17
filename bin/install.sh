#!/bin/bash
#******************************************************************************
#
# Shell Script to setup the development environment
#
# Copyright (c) 2015 Roger Ye.  All rights reserved.
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

export TOOLROOT=${HOME}/arm-2013.11
CODEBENCH_EABI_IMAGE=arm-2013.11-24-arm-none-eabi-i686-pc-linux-gnu.tar.bz2
CODEBENCH_LINUX_IMAGE=arm-2013.11-33-arm-none-linux-gnueabi-i686-pc-linux-gnu.tar.bz2
CODEBENCH_EABI_URL=https://sourcery.mentor.com/public/gnu_toolchain/arm-none-eabi/arm-2013.11-24-arm-none-eabi-i686-pc-linux-gnu.tar.bz2
CODEBENCH_LINUX_URL=http://sourcery.mentor.com/public/gnu_toolchain/arm-none-linux-gnueabi/arm-2013.11-33-arm-none-linux-gnueabi-i686-pc-linux-gnu.tar.bz2


DOWNLOAD=$HOME/src/download

if [ `uname -p` = "x86_64" ]; then
	echo "Initializing x86_64 version ..."
	export AndroidSDK=$HOME/adt-bundle-linux-x86_64-20140702/sdk
	SDK_IMAGE=adt-bundle-linux-x86_64-20140702.zip
	SDK_URL=https://dl.google.com/android/adt/adt-bundle-linux-x86_64-20140702.zip
else
	echo "Initializing x86 version ..."
	export AndroidSDK=$HOME/adt-bundle-linux-x86-20140702/sdk
	SDK_IMAGE=adt-bundle-linux-x86-20140702.zip
	SDK_URL=https://dl.google.com/android/adt/adt-bundle-linux-x86-20140702.zip
fi

echo "This script will download and install CodeBench Lite and Android SDK for you."
echo "Android SDK will be installed at:"
echo "  $AndroidSDK"
echo "CodeBench Lite will be installed at:"
echo "  $TOOLROOT"

echo -n "Do you want to start the installation? [y/n]?"
read choice

if [ "$choice" == "y" ]; then
	echo "Starting the installation..."
else
	echo "Exit from the installation."
	exit
fi

echo ""
if [ -x $DOWNLOAD ]; then
	echo "You already have download folder."
else
        echo "Create download folder."
	mkdir -p $DOWNLOAD
fi

echo "Downloading CodeBench Lite ..."
if [ -f $DOWNLOAD/$CODEBENCH_EABI_IMAGE ]; then
	echo $DOWNLOAD/$CODEBENCH_EABI_IMAGE
else
	wget -O $DOWNLOAD/$CODEBENCH_EABI_IMAGE $CODEBENCH_EABI_URL
fi

if [ -f $DOWNLOAD/$CODEBENCH_LINUX_IMAGE ]; then
	echo $DOWNLOAD/$CODEBENCH_LINUX_IMAGE
else
	wget -O $DOWNLOAD/$CODEBENCH_LINUX_IMAGE $CODEBENCH_LINUX_URL
fi

echo "Downloading Android SDK ..."
if [ -f $DOWNLOAD/$SDK_IMAGE ]; then
	echo $DOWNLOAD/$SDK_IMAGE
else
	wget -O $DOWNLOAD/$SDK_IMAGE $SDK_URL
fi

echo ""
echo "Starting the installation ..."
cd $HOME

if [ -x $TOOLROOT/arm-none-eabi ]; then
	echo "You already have $TOOLROOT/arm-none-eabi."
else
	tar xvfj $DOWNLOAD/$CODEBENCH_EABI_IMAGE
fi

if  [ -x $TOOLROOT/arm-none-linux-gnueabi ]; then
	echo "You already have $TOOLROOT/arm-none-linux-gnueabi."
else
	tar xvfj $DOWNLOAD/$CODEBENCH_LINUX_IMAGE
fi

if [ -x $AndroidSDK ]; then
	echo "You already have Android SDK."
else
	unzip $DOWNLOAD/$SDK_IMAGE
fi

if [ -x ${AndroidSDK}/platforms/android-15 ]; then
        echo "Find API level 15."
else
        echo "Cannot find API level 15. Please download API level 15 in order to create the version of virtual device needed in this book."
	AndroidP15=`$AndroidSDK/tools/android list sdk -a | grep "SDK Platform Android 4.0.3, API 15"`
	AndroidVer1=`echo $AndroidP15 | grep -Eo "^[[:digit:]]{2}"`
#	echo $AndroidVer1
	AndroidP15=`$AndroidSDK/tools/android list sdk -a | grep "ARM EABI v7a System Image, Android API 15"`
	AndroidVer2=`echo $AndroidP15 | grep -Eo "^[[:digit:]]{2}"`
#	echo $AndroidVer2
	$AndroidSDK/tools/android update sdk -u -a -t $AndroidVer1,$AndroidVer2
fi

echo ""
echo "Please refer to chapter 2 to create an Android Virtual Device."
echo "Please add $HOME/src/build/bin in your path and"
echo "add $HOME/src/build/bin/setup.sh in your .bashrc."
