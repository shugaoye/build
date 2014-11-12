# Debug u-boot
target remote localhost:1234
b board_init_f
c
b relocate_code
c
p/x ((gd_t *)$r1)->relocaddr
d
symbol-file ./u-boot/u-boot
add-symbol-file ./u-boot/u-boot 0x1ff57000
b board_init_r
