#!/bin/sh

echo "Welcome to magic-arch-installer."
echo "Install arch linux in few clicks. Even a 5 year kid can install arch now."
pacman -Sy
timedatectl set-ntp true
clear
lsblk
echo "Enter the drive to create partitions for linux systems ( eg: /dev/sda). "
echo "root, home, swap partitions need to be created. home and swap partitions are optional but recommended: "
read drive

# you can use cfdisk or gdisk in place of fdisk as well.
fdisk $drive
clear
lsblk
echo "Enter the root partition (eg: /dev/sda1): "
read rootpartition
mkfs.ext4 $rootpartition
mount $rootpartition /mnt
clear
lsblk
read -p "Did you also create separate home partition? [y/n]: " answerhome
if [[ $answerhome = y ]] ; then
  echo "Enter home partition (eg: /dev/sda2): "
  read homepartition
  mkfs.ext4 $homepartition
  mkdir /mnt/home
  mount $homepartition /mnt/home
fi
clear
lsblk
read -p "Did you also create swap partition? [y/n]: " answerswap
if [[ $answerswap = y ]] ; then
  echo "Enter swap partition (eg: /dev/sda3): "
  read swappartition
  mkswap $swappartition
  swapon $swappartition
fi
clear
lsblk
sleep 5s
#Replace kernel header file and with your requirements (eg linux-zen linux-zen-headers)
#replace intel-ucode with amd-ucode if you use amd processor
pacstrap /mnt base base-devel linux-lts linux-lts-headers intel-ucode
genfstab -U /mnt >> /mnt/etc/fstab
sed '1,/^#part2$/d' legacy-base-install.sh > /mnt/post_base-install.sh
chmod +x /mnt/post_base-install.sh
arch-chroot /mnt ./post_base-install.sh
clear
umount -R /mnt
echo "Pre-Installation Finished. Rebooting in 10 seconds"
echo "You can install gui and other utilities after rebooting."
echo "You can check https://github.com/whoisYoges/magic-arch-installer/ for gui and other utilities installation/automation scripts."
sleep 10s
reboot
exit

#part2
#Replace Asia/Kathmandu with your timezone
clear
ln -sf /usr/share/zoneinfo/Asia/Kathmandu /etc/localtime
hwclock --systohc
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
clear
echo "Enter your computer name: "
read hostname
echo $hostname > /etc/hostname
echo "127.0.0.1       localhost" >> /etc/hosts
echo "::1             localhost" >> /etc/hosts
echo "127.0.1.1       $hostname" >> /etc/hosts
clear
#if you are dualbooting, add os-prober with grub and efibootmgr

echo"Installing Grub"
sleep 5s
echo "Getting grub bootloader."
pacman -Sy --needed grub 
echo "Enter the drive to install grub ( eg: /dev/sda). "
echo "Note: Remember not to add sda1 or sda2 it's just /dev/sda or /dev/sdb."
read grubdrive
grub-install --target=i386-pc $grubdrive
grub-mkconfig -o /boot/grub/grub.cfg
pacman -S networkmanager
systemctl enable NetworkManager
clear
echo "Add password for root user:"
passwd
clear
echo "Lets add a regular user..."
echo "It is different from your computer name."
echo "Set Username (it is used to login to your system): "
read username
useradd -m -g users -G wheel -s /bin/bash $username
echo "Enter password for user '$username' :"
passwd $username
clear
echo "NOTE: ALWAYS REMEMBER THIS USERNAME AND PASSWORD YOU PUT JUST NOW."
sleep 3s
#Adding sudo previliages to the user you created
echo "$username ALL=(ALL) ALL" >> /etc/sudoers.d/$username
clear
rm /post_base-install.sh
exit
