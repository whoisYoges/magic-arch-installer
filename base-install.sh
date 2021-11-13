echo "Welcome to magic-arch-installer."
echo "Install arch linux in few clicks. Even a 5 year kid can install arch now."
pacman -Sy
timedatectl set-ntp true
clear
lsblk
echo "Enter the drive to create partitions for linux systems ( eg: /dev/sda). "
echo "root, home, swap, boot/efi partitions need to be created. home and swap partitions are optional but recommended: "
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
echo "Enter EFI partition (eg: /dev/sda4): "
read efipartition
mkfs.vfat -F 32 $efipartition
mkdir -p /mnt/boot/efi
mount $efipartition /mnt/boot/efi
clear
lsblk
sleep 2s
#Replace kernel header file and with your requirements (eg linux-zen linux-zen-headers)
#replace intel-ucode with amd-ucode if you use amd processor
pacstrap /mnt base base-devel linux-lts linux-lts-headers intel-ucode
genfstab -U /mnt >> /mnt/etc/fstab
sed '1,/^#part2$/d' base-install.sh > /mnt/post_base-install.sh
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
pacman -Sy --needed grub efibootmgr
echo "Installing grub bootloader in /boot/efi parttiton"
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB --removable
grub-mkconfig -o /boot/grub/grub.cfg
pacman -S networkmanager
systemctl enable NetworkManager
clear
echo "Enter password for root user:"
passwd
clear
echo "Enter username to add a regular user: "
read username
useradd -m -g users -G wheel -s /bin/bash $username
echo "Enter password for the user you created just now:"
passwd $username
clear
echo "NOTE: ALWAYS REMEMBER THIS USERNAME AND PASSWORD YOU PUT JUST NOW."
sleep 3s
#Adding sudo previliages to the user you created
echo "$username ALL=(ALL) ALL" >> /etc/sudoers.d/$username
clear
rm /post_base-install.sh
exit
