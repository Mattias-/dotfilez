#!/bin/bash
set -euo pipefail

EXTRA_PACKAGES="sway termite vim"
NEWHOSTNAME=myhostname
TIMEZONE=Europe/Stockholm
DISK=/dev/sda
BOOT_PARTITION=${DISK}1
ROOT_PARTITION=${DISK}2

make_partitions() {
    cat >./disk.sfdisk <<EOF
label: gpt
label-id: $(uuidgen)
unit: sectors

${BOOT_PARTITION} : start=2048, size=512MiB, type=C12A7328-F81F-11D2-BA4B-00A0C93EC93B
${ROOT_PARTITION} : type=0FC63DAF-8483-4772-8E79-3D69D8477DE4
EOF
    sfdisk ${DISK} <./disk.sfdisk

    cryptsetup -y -v luksFormat --type luks2 ${ROOT_PARTITION}
    cryptsetup open ${ROOT_PARTITION} cryptroot
    mkfs.ext4 /dev/mapper/cryptroot
    mount /dev/mapper/cryptroot /mnt

    mkfs.fat -F32 ${BOOT_PARTITION}
    mkdir /mnt/boot
    mount ${BOOT_PARTITION} /mnt/boot
}

setup_boot() {
    echo "FONT=ter-p28n" >>/mnt/etc/vconsole.conf
    sed -i "s/^HOOKS=.*/HOOKS=(base systemd autodetect keyboard sd-vconsole modconf block sd-encrypt filesystems fsck)/" /mnt/etc/mkinitcpio.conf
    arch-chroot /mnt mkinitcpio -p linux

    bootctl --path=/mnt/boot install
    cp -f /mnt/usr/share/systemd/bootctl/loader.conf /mnt/boot/loader/loader.conf
    cp -f /mnt/usr/share/systemd/bootctl/arch.conf /mnt/boot/loader/entries/
    bootctl --path=/mnt/boot status
    ROOT_UUID=$(blkid -s UUID -o value ${ROOT_PARTITION})
    sed -i "s@^options .*@options rd.luks.name=${ROOT_UUID}=cryptroot root=/dev/mapper/cryptroot rw quiet splash@" /mnt/boot/loader/entries/arch.conf
}

setup_root() {
    genfstab -U /mnt >>/mnt/etc/fstab

    # Copy current network settings
    cp -r /etc/netctl/* /mnt/etc/netctl/

    echo "$NEWHOSTNAME" >/mnt/etc/hostname
    cat >/mnt/etc/hosts <<EOF
127.0.0.1	localhost
::1		localhost
127.0.1.1	$NEWHOSTNAME.localdomain	$NEWHOSTNAME
EOF

    echo "en_US.UTF-8 UTF-8" >>/mnt/etc/locale.gen
    chroot /mnt locale-gen
    echo "LANG=en_US.UTF-8" >>/mnt/etc/locale.conf

    chroot /mnt ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime
    arch-chroot /mnt hwclock --systohc

    chroot /mnt passwd
}

# Install a better terminal font to make installation readable
pacman --noconfirm -Sy terminus-font
setfont ter-p28n

make_partitions

pacstrap /mnt \
    base \
    base-devel \
    terminus-font \
    dialog \
    wpa_supplicant \
    ${EXTRA_PACKAGES}

setup_boot
setup_root
