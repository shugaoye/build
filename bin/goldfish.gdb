#******************************************************************************
#
# GDB Script used to debug goldfish kernel
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

# Debug goldfish kernel
d
symbol-file ./goldfish/vmlinux
add-symbol-file ./goldfish/vmlinux 0x00010000
b start_kernel
# b rest_init
# b prepare_namespace
# b identify_ramdisk_image
# b initrd_load
# b mount_root
# b mount_block_root
# b sys_mount
# b do_mount
# b vfs_kern_mount
