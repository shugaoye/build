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
