#!/usr/bin/env bash
echo -ne "
__________________________________________________________________________________________________________
|                                                                                                         |
|                                  ███    ███  █████   ██████  ██  ██████                                 |
|                                  ████  ████ ██   ██ ██       ██ ██                                      |
|                                  ██ ████ ██ ███████ ██   ███ ██ ██                                      |
|                                  ██  ██  ██ ██   ██ ██    ██ ██ ██                                      |
|                                  ██      ██ ██   ██  ██████  ██  ██████                                 |
|                                                                                                         |
| █████  ██████   ██████ ██   ██     ██ ███    ██ ███████ ████████  █████  ██      ██      ███████ ██████ |
|██   ██ ██   ██ ██      ██   ██     ██ ████   ██ ██         ██    ██   ██ ██      ██      ██      ██   ██|
|███████ ██████  ██      ███████     ██ ██ ██  ██ ███████    ██    ███████ ██      ██      █████   ██████ |
|██   ██ ██   ██ ██      ██   ██     ██ ██  ██ ██      ██    ██    ██   ██ ██      ██      ██      ██   ██|
|██   ██ ██   ██  ██████ ██   ██     ██ ██   ████ ███████    ██    ██   ██ ███████ ███████ ███████ ██   ██|
|                                                                                                         |
|---------------------------------------------------------------------------------------------------------|
|                Install arch linux in few clicks. Even a 5 year kid can install arch now.                |
|---------------------------------------------------------------------------------------------------------|
|                               Base Installation Of Arch Linux Begins Now                                |
| Check: https://github.com/whoisYoges/magic-arch-installer/ To Know More Details About This Installation |
|---------------------------------------------------------------------------------------------------------|
|_________________________________________________________________________________________________________|

"
sleep 3s
echo "Internet Connection is a must to begin."
echo "Updating Keyrings"
sleep 2s
pacman -Sy --needed --noconfirm archlinux-keyring
clear
echo "Ensuring if the system clock is accurate."
timedatectl set-ntp true
sleep 3s
clear

lsblk
echo "Enter the drive to install arch linux on it. (/dev/...)"
echo "Enter Drive (eg. /dev/sda or /dev/vda or /dev/nvme0n1 or something similar)"
read drive
sleep 2s
clear


lsblk
echo "Choose a familier disk utility tool to partition your drive!"
echo " 1. fdisk"
echo " 2. cfdisk"
echo " 3. gdisk"
echo " 4. parted"
read partitionutility

case "$filesystemtype" in
  1 | fdisk | Fdisk | FDISK)
  partitionutility="fdisk"
  ;;
  2 | cfdisk | Cfdisk | CFDISK)
  partitionutility="cfdisk"
  ;;
  3 | gdisk | Gdisk | GDISK)
  partitionutility="gdisk"
  ;;
  4 | parted | Parted | PARTED)
  partitionutility="parted"
  ;;
  *)
  echo "Unknown or unsupported disk utility! Default = cfdisk."
  partitionutility="cfdisk"
  ;;
esac
echo ""$partitionutility" is the selected disk utility tool for partition."
sleep 3s
clear
echo "Getting ready for creating partitions!"
echo "root partition is mandatory."
echo "home and swap partitions are optional but recommended!"
echo "Also, you can create a separate partition for timeshift backup (optional)!"
sleep 3s
"$partitionutility" "$drive"
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
sleep 3s
clear
#Replace kernel and kernel-header file and with your requirements (eg linux-zen linux-zen-headers or linux linux-headers)
#Include intel-ucode/amd-ucode if you use intel/amd processor.
echo "Installing Base system with lts kernel!!!"
sleep 2s
pacstrap /mnt base base-devel linux-lts linux-lts-headers
clear
echo "generating fstab file"
genfstab -U /mnt >> /mnt/etc/fstab
sleep 2s
clear
sed '1,/^#part2$/d' legacy-base-install.sh > /mnt/post_base-install.sh
chmod +x /mnt/post_base-install.sh
arch-chroot /mnt ./post_base-install.sh
clear
echo "unmounting all the drives"
umount -R /mnt
sleep 2s
clear
echo -ne "
__________________________________________________________________________________________________________
|                                            THANKS FOR USING                                             |
|---------------------------------------------------------------------------------------------------------|
|                                  ███    ███  █████   ██████  ██  ██████                                 |
|                                  ████  ████ ██   ██ ██       ██ ██                                      |
|                                  ██ ████ ██ ███████ ██   ███ ██ ██                                      |
|                                  ██  ██  ██ ██   ██ ██    ██ ██ ██                                      |
|                                  ██      ██ ██   ██  ██████  ██  ██████                                 |
|                                                                                                         |
| █████  ██████   ██████ ██   ██     ██ ███    ██ ███████ ████████  █████  ██      ██      ███████ ██████ |
|██   ██ ██   ██ ██      ██   ██     ██ ████   ██ ██         ██    ██   ██ ██      ██      ██      ██   ██|
|███████ ██████  ██      ███████     ██ ██ ██  ██ ███████    ██    ███████ ██      ██      █████   ██████ |
|██   ██ ██   ██ ██      ██   ██     ██ ██  ██ ██      ██    ██    ██   ██ ██      ██      ██      ██   ██|
|██   ██ ██   ██  ██████ ██   ██     ██ ██   ████ ███████    ██    ██   ██ ███████ ███████ ███████ ██   ██|
|                                                                                                         |
|---------------------------------------------------------------------------------------------------------|
|                Install arch linux in few clicks. Even a 5 year kid can install arch now.                |
|---------------------------------------------------------------------------------------------------------|
|                          Base Installation Of Arch Linux Is Completed Now                               |
|Check: https://github.com/whoisYoges/magic-arch-installer for Graphical User Interface (GUI) Installation|
|---------------------------------------------------------------------------------------------------------|
|_________________________________________________________________________________________________________|
"
echo "Base Installation Finished. REBOOTING IN 10 SECONDS!!!"
sleep 10s
reboot

#part2
clear
echo "Working inside new root system!!!"
echo "setting timezone"
#Replace Asia/Kathmandu with your timezone
ln -sf /usr/share/zoneinfo/Asia/Kathmandu /etc/localtime
hwclock --systohc
sleep 2s
clear
echo "generating locale"
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
sleep 2s
clear
echo "setting LANG variable"
echo "LANG=en_US.UTF-8" > /etc/locale.conf
sleep 2s
clear
echo "setting console keyboard layout"
echo "KEYMAP=us" > /etc/vconsole.conf
sleep 2s
clear
echo "Set up your hostname!"
echo "Enter your computer name: "
read hostname
echo $hostname > /etc/hostname
echo "Checking hostname (/etc/hostname)"
cat /etc/hostname
sleep 3s
clear
echo "setting up hosts file"
echo "127.0.0.1       localhost" >> /etc/hosts
echo "::1             localhost" >> /etc/hosts
echo "127.0.1.1       $hostname" >> /etc/hosts
clear
echo "checking /etc/hosts file"
cat /etc/hosts
sleep 3s
clear
#if you are dualbooting, add os-prober with grub and efibootmgr
echo "Installing grub efibootmgr and networkmanager"
sleep 2s
pacman -Sy --needed --noconfirm grub efibootmgr networkmanager
clear

lsblk
echo "Installing grub bootloader in /boot/efi parttiton"
sleep 2s
echo "Enter the drive name to install bootloader in it. (eg: /dev/sda or /dev/nvme01 or /dev/vda or something similar)! "
echo "NOTE: JUST GIVE DRIVE NAME (/dev/sda); NOT THE PARTITION NAME (/dev/sda1)"
echo "Enter the drive name: "
read grubdrive
grub-install --target=i386-pc "$grubdrive"
grub-mkconfig -o /boot/grub/grub.cfg
sleep 2s
clear
echo "Enabling NetworkManager"
systemctl enable NetworkManager
sleep 2s
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
echo "Giving sudo access to "$username"!"
echo "$username ALL=(ALL) ALL" >> /etc/sudoers.d/$username
clear
rm /post_base-install.sh
exit
