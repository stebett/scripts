#!/usr/bin/fish  

efibootmgr --disk /dev/mmcblk1 --part 1 --create --label "Arch Linux" --loader /vmlinuz-linux --unicode 'root=PARTUUID=8c7ca56b-08d0-4227-9c31-7cb51f330fcd rw initrd=\initramfs-linux.img' --verbose


