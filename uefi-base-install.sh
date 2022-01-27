#!/usr/bin/env bash
echo -ne "
---------------------------------------------------------------------------------------------------------
                                  ███    ███  █████   ██████  ██  ██████ 
                                  ████  ████ ██   ██ ██       ██ ██      
                                  ██ ████ ██ ███████ ██   ███ ██ ██      
                                  ██  ██  ██ ██   ██ ██    ██ ██ ██      
                                  ██      ██ ██   ██  ██████  ██  ██████ 
                                       
 █████  ██████   ██████ ██   ██     ██ ███    ██ ███████ ████████  █████  ██      ██      ███████ ██████  
██   ██ ██   ██ ██      ██   ██     ██ ████   ██ ██         ██    ██   ██ ██      ██      ██      ██   ██ 
███████ ██████  ██      ███████     ██ ██ ██  ██ ███████    ██    ███████ ██      ██      █████   ██████  
██   ██ ██   ██ ██      ██   ██     ██ ██  ██ ██      ██    ██    ██   ██ ██      ██      ██      ██   ██ 
██   ██ ██   ██  ██████ ██   ██     ██ ██   ████ ███████    ██    ██   ██ ███████ ███████ ███████ ██   ██ 
                                                                                                          
---------------------------------------------------------------------------------------------------------
                  Install arch linux in few clicks. Even a 5 year kid can install arch now.
---------------------------------------------------------------------------------------------------------

"
echo "Internet Connection is a must to begin."
sleep 5s
echo "Updating Keyrings"
pacman -Sy --needed archlinux-keyring
clear
echo "Ensuring if the system clock is accurate."
timedatectl set-ntp true
sleep 3s
clear

lsblk
echo "Enter the drive to create partitions for linux systems ( eg: /dev/sda). "
echo "root and boot partitions are mandatory."
echo "home and swap partitions are optional but recommended! "
echo "Also, you can create a separate partition for timeshift backup (optional): "
read drive

# you can use cfdisk or gdisk in place of fdisk as well.
fdisk $drive
clear
lsblk
echo "choose your linux file system type for formatting drives"
echo " 1. ext4"
echo " 2. xfs"
echo " 3. btrfs"
echo " 4. f2fs"
echo " Boot partition will be formatted in fat32 file system type."
read filesystemtype

case "$filesystemtype" in
  1 | ext4 | Ext4 | EXT4)
  filesystemtype="ext4"
  ;;
  2 | xfs | Xfs | XFS)
  filesystemtype="xfs"
  ;;
  3 | btrfs | Btrfs | BTRFS)
  filesystemtype="btrfs"
  ;;
  4 | f2fs | F2fs | F2FS)
  filesystemtype="f2fs"
  ;;
  *)
  echo "Unknown or unsupported Filesystem. Default = ext4."
  filesystemtype="ext4"
  ;;
esac
echo ""$filesystemtype" is the selected file system type."
sleep 3s
clear
echo "Getting ready for formatting drives."
sleep 3s
lsblk
echo "Enter the root partition (eg: /dev/sda1): "
read rootpartition
mkfs."$filesystemtype" "$rootpartition"
mount "$rootpartition" /mnt
clear
lsblk
read -p "Did you also create separate home partition? [y/n]: " answerhome
case "$answerhome" in
  y | Y | yes | Yes | YES)
  echo "Enter home partition (eg: /dev/sda2): "
  read homepartition
  mkfs."$filesystemtype" "$homepartition"
  mkdir /mnt/home
  mount "$homepartition" /mnt/home
  ;;
  *)
  echo "Skipping home partition!"
  ;;
esac
clear
lsblk
read -p "Did you also create swap partition? [y/n]: " answerswap
case "$answerswap" in
  y | Y | yes | Yes | YES)
  echo "Enter swap partition (eg: /dev/sda3): "
  read swappartition
  mkswap "$swappartition"
  swapon "$swappartition"
  ;;
  *)
  echo "Skipping Swap partition!"
  ;;
esac

clear
lsblk
echo "Operations on efi parttiton will be done later.): "
sleep 3s
clear
#Replace kernel header file and with your requirements (eg linux-zen linux-zen-headers)
#replace intel-ucode with amd-ucode if you use amd processor
echo "Installing Base system!!!"
pacstrap /mnt base base-devel linux-lts linux-lts-headers intel-ucode
clear
echo "generating fstab file"
genfstab -U /mnt >> /mnt/etc/fstab
sleep 2s
clear
echo "Working inside new root system!!!"
sed '1,/^#part2$/d' uefi-base-install.sh > /mnt/post_base-install.sh
chmod +x /mnt/post_base-install.sh
echo "Working inside new root system!!!"
arch-chroot /mnt ./post_base-install.sh
clear
umount -R /mnt
echo "Pre-Installation Finished. Rebooting in 10 seconds"
echo "You can install gui and other utilities after rebooting."
echo "You can check https://github.com/whoisYoges/magic-arch-installer/ for gui and other utilities installation/automation scripts."
sleep 10s
reboot

#part2
#Replace Asia/Kathmandu with your timezone
clear
echo "setting timezone"
ln -sf /usr/share/zoneinfo/Asia/Kathmandu /etc/localtime
hwclock --systohc
echo "generating locale"
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "setting LANG variable"
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "setting console keyboard layout"
echo "KEYMAP=us" > /etc/vconsole.conf
clear
echo "Set up your hostname!"
echo "Enter your computer name: "
read hostname
echo $hostname > /etc/hostname
echo "setting up hosts file"
echo "127.0.0.1       localhost" >> /etc/hosts
echo "::1             localhost" >> /etc/hosts
echo "127.0.1.1       $hostname" >> /etc/hosts
clear
#if you are dualbooting, add os-prober with grub and efibootmgr
echo "Installing grub efibootmgr and networkmanager"
sleep 2s
pacman -Sy --needed grub efibootmgr networkmanager
clear

lsblk
echo "Enter the efi partition to install grub. (eg: /dev/sda1): "
read efipartition
mkfs.fat -F 32 "$efipartition"
efidirectory="/boot/efi/"
if [ ! -d "$efidirectory" ]; then
  mkdir -p "$efidirectory"
fi
mount "$efipartition" "$efidirectory"
clear
mkinitcpio -P
clear
lsblk
echo "Installing grub bootloader in /boot/efi parttiton"
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB --removable
grub-mkconfig -o /boot/grub/grub.cfg
echo "Enabling NetworkManager"
systemctl enable NetworkManager
clear
echo "Enter password for root user:"
passwd
clear
echo "Adding regular user!"
echo "Enter username to add a regular user: "
read username
useradd -m -g users -G wheel,audio,video -s /bin/bash $username
echo "Enter password for "$username": "
passwd $username
clear
echo "NOTE: ALWAYS REMEMBER THIS USERNAME AND PASSWORD YOU PUT JUST NOW."
sleep 3s
#Adding sudo previliages to the user you created
echo "$username ALL=(ALL) ALL" >> /etc/sudoers.d/$username
clear
rm /post_base-install.sh
exit
exit