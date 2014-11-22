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

echo Setup development environment for Android SDK and Sourcery CodeBench.
export TOOLROOT=${HOME}/arm-2013.11
export ARCH=arm
export SUBARCH=arm
AndroidSDK=$HOME/adt-bundle-linux-x86-20140702/sdk

export PATH=${TOOLROOT}/bin:$PATH:${AndroidSDK}/platform-tools:${AndroidSDK}/tools
