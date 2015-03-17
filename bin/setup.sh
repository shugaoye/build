#!/bin/bash
#******************************************************************************
#
# Shell Script used to setup the development environment
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

echo "Setup development environment for Android SDK and Sourcery CodeBench."
echo "Using CodeBench Lite arm-2013.11-24-arm-none-eabi-i686-pc-linux-gnu.tar.bz2"
echo "Android SDK 24.1.2 and API 22"
export TOOLROOT=${HOME}/arm-2013.11
export ARCH=arm
export SUBARCH=arm
AndroidSDK=$HOME/adt-bundle-linux-x86_64-20140702/sdk

if [ -x ${AndroidSDK}/platforms/android-15 ]; then
        echo "Find API level 15."
else
        echo "Cannot find API level 15. Please download API level 15 in order to create the version of virtual device needed in this book."
	return
fi

if [ -x $HOME/.android/avd/hd2.avd ]; then
        echo "Find AVD hd2."
else
        echo "Cannot find AVD hd2. Please create a virtual device based on API level 15 referring to Figure 2-3."
	return
fi

export PATH=$HOME/src/build/bin:${TOOLROOT}/bin:$PATH:${AndroidSDK}/platform-tools:${AndroidSDK}/tools
echo TOOLROOT=${HOME}/arm-2013.11
echo Android SDK path is $AndroidSDK.
