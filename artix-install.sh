#! /bin/sh
chroot(){
basestrap /mnt base base-devel runit linux linux-firmware dhcpcd wpa_supplicant wpa_supplicant-runit nvim grub
fstabgen -U /mnt >> /mnt/etc/fstab
artools-chroot /mnt ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
artools-chroot /mnt hwclock --systohc
artools-chroot /mnt sed -i /etc/locale.gen 's/#en-US UTF-8/en-US UTF-8'
artools-chroot /mnt locale-gen
artools-chroot /mnt grub-install --recheck /dev/sda
artools-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg
artools-chroot passwd
artools-chroot useradd -m -G wheel,audio,video zezin
artools-chroot passwd zezin
artools-chroot touch /etc/hostname 
artools-chroot echo "thiccpad" >> /etc/hostname 
artools-chroot cat > /etc/hosts << EOF 
127.0.0.1	localhost
::1		localhost
127.0.1.1	thiccpad.localdomain	thiccpad
EOF
mv artix-install/artix-install.sh /mnt
}

[ $1 = "--pre" ] && { 
    chroot
}

